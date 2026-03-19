#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any


TEMPLATE_DASHBOARDS = [
    "nginx_api_observability.json",
    "container_logs_dashboard.json",
    "system_monitoring.json",
]


def _lock_variable(dashboard: dict[str, Any], name: str, value: str, required: bool = False) -> None:
    templating = dashboard.get("templating", {})
    variables = templating.get("list", [])
    for variable in variables:
        if variable.get("name") != name:
            continue

        # Lock a dashboard variable to a single value and hide it in project-specific folders.
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
        return

    if required:
        raise RuntimeError(f"Template dashboards must define a variable named '{name}'.")


def _project_uid(project: str, base_uid: str | None) -> str:
    base_uid = (base_uid or "dashboard").strip() or "dashboard"
    return f"{project}-{base_uid}"


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

        dst = out_dir / filename
        if dst.exists() and not overwrite:
            print(f"skip: {dst} (already exists; use --overwrite)", file=sys.stderr)
            continue

        dashboard = json.loads(src.read_text(encoding="utf-8"))
        dashboard["uid"] = _project_uid(project, dashboard.get("uid"))

        title = str(dashboard.get("title") or "Dashboard")
        dashboard["title"] = f"[{project}] {title}"

        tags = dashboard.get("tags")
        if isinstance(tags, list):
            if project not in tags:
                tags.append(project)
        else:
            dashboard["tags"] = [project]

        _lock_variable(dashboard, "project", project, required=True)
        if vps:
            _lock_variable(dashboard, "vps", vps)

        dst.write_text(json.dumps(dashboard, indent=4, ensure_ascii=False) + "\n", encoding="utf-8")
        print(f"wrote: {dst.relative_to(repo_root)}")
        wrote_any = True

    if not wrote_any:
        # Nothing to do (all dashboards already exist and --overwrite not used).
        # Treat this as a successful no-op so `make dashboards_project` doesn't fail.
        return 0

    return 0


def main() -> int:
    parser = argparse.ArgumentParser(
        description=(
            "Generate per-project Grafana dashboards (1 folder per project) from the"
            " templates in central/dashboards/projects/_all."
        )
    )
    parser.add_argument(
        "project",
        help="Project identifier (recommended: Swarm stack name used with docker stack deploy).",
    )
    parser.add_argument(
        "--vps",
        help="Optional VPS identifier to lock System dashboard to a single VPS.",
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
