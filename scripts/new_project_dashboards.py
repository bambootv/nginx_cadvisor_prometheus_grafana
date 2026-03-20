#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path
from typing import Any


TEMPLATE_DASHBOARDS = [
    "nginx_api_observability.json",
    "container_logs_dashboard.json",
    "system_monitoring.json",
]


def _safe_suffix(value: str) -> str:
    cleaned = re.sub(r"[^A-Za-z0-9._-]+", "-", value.strip())
    cleaned = cleaned.strip("-")
    return cleaned or "vps"


def _dashboard_filename(template_name: str, vps: str) -> str:
    return template_name


def _lock_variable(dashboard: dict[str, Any], name: str, value: str, required: bool = False) -> None:
    templating = dashboard.get("templating", {})
    variables = templating.get("list", [])
    for variable in variables:
        if variable.get("name") != name:
            continue

        variable["hide"] = 2
        variable["skipUrlSync"] = True
        variable["refresh"] = 0
        variable["multi"] = False
        variable["includeAll"] = False
        variable["type"] = "constant"
        variable["query"] = value
        variable["definition"] = value
        variable["options"] = [{"selected": True, "text": value, "value": value}]
        variable["current"] = {"selected": True, "text": value, "value": value}
        variable.pop("datasource", None)
        variable.pop("allValue", None)
        return

    if required:
        raise RuntimeError(f"Template dashboards must define a variable named '{name}'.")


def _set_default_variable(
    dashboard: dict[str, Any],
    name: str,
    value: str,
    *,
    required: bool = False,
) -> None:
    templating = dashboard.get("templating", {})
    variables = templating.get("list", [])
    for variable in variables:
        if variable.get("name") != name:
            continue

        variable["hide"] = 0
        variable["skipUrlSync"] = False
        variable["refresh"] = max(int(variable.get("refresh", 1) or 1), 1)
        variable["multi"] = False
        variable["includeAll"] = False
        variable["current"] = {"selected": True, "text": value, "value": value}
        variable["options"] = [{"selected": True, "text": value, "value": value}]
        variable.pop("allValue", None)
        return

    if required:
        raise RuntimeError(f"Template dashboards must define a variable named '{name}'.")


def _dashboard_uid(project: str, vps: str, base_uid: str | None) -> str:
    base_uid = (base_uid or "dashboard").strip() or "dashboard"
    project_part = _safe_suffix(project)[:10] or "project"
    base_part = _safe_suffix(base_uid)[:12] or "dashboard"
    scope = f"{project}|{base_uid}"
    digest = hashlib.sha1(scope.encode("utf-8")).hexdigest()[:10]
    return f"{project_part}-{base_part}-{digest}"


def _dashboard_title(project: str, vps: str, title: str) -> str:
    return f"[{project}] {title}"


def generate_project_dashboards(project: str, vps: str = "", overwrite: bool = False) -> int:
    project = project.strip()
    vps = vps.strip()
    if not project:
        print("error: project must be non-empty", file=sys.stderr)
        return 2

    repo_root = Path(__file__).resolve().parents[1]
    templates_dir = repo_root / "central" / "dashboards" / "projects" / "_all"
    out_dir = repo_root / "central" / "dashboards" / "projects" / project

    if not templates_dir.is_dir():
        print(f"error: templates dir not found: {templates_dir}", file=sys.stderr)
        return 2

    out_dir.mkdir(parents=True, exist_ok=True)

    wrote_any = False
    for filename in TEMPLATE_DASHBOARDS:
        src = templates_dir / filename
        if not src.is_file():
            print(f"error: missing template dashboard: {src}", file=sys.stderr)
            return 2

        dst = out_dir / _dashboard_filename(filename, vps)
        if dst.exists() and not overwrite:
            print(f"skip: {dst} (already exists; use --overwrite)", file=sys.stderr)
            continue

        dashboard = json.loads(src.read_text(encoding="utf-8"))
        dashboard["uid"] = _dashboard_uid(project, vps, dashboard.get("uid"))
        dashboard["title"] = _dashboard_title(project, vps, str(dashboard.get("title") or "Dashboard"))

        tags = dashboard.get("tags")
        if isinstance(tags, list):
            if project not in tags:
                tags.append(project)
        else:
            dashboard["tags"] = [project]

        _lock_variable(dashboard, "project", project, required=True)
        if vps:
            _set_default_variable(dashboard, "vps", vps, required=True)

        dst.write_text(json.dumps(dashboard, indent=4, ensure_ascii=False) + "\n", encoding="utf-8")
        print(f"wrote: {dst.relative_to(repo_root)}")
        wrote_any = True

    if not wrote_any:
        return 0

    return 0


def main() -> int:
    parser = argparse.ArgumentParser(
        description=(
            "Generate per-project Grafana dashboards from the templates in "
            "central/dashboards/projects/_all. When --vps is provided, the project "
            "dashboards still keep the same filenames and titles, but the VPS filter "
            "defaults to that VPS and does not expose All."
        )
    )
    parser.add_argument(
        "project",
        help="Project identifier (recommended: Swarm stack name used with docker stack deploy).",
    )
    parser.add_argument(
        "--vps",
        help="Optional default VPS for the dashboard filter. Files and titles stay per-project only.",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Overwrite dashboards if the destination files already exist.",
    )
    args = parser.parse_args()

    return generate_project_dashboards(args.project, vps=args.vps or "", overwrite=args.overwrite)


if __name__ == "__main__":
    raise SystemExit(main())
