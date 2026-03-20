#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from new_project_dashboards import TEMPLATE_DASHBOARDS, generate_project_dashboards


def _read_variable_value(dashboard_path: Path, variable_name: str) -> str:
    if not dashboard_path.is_file():
        return ""

    try:
        dashboard = json.loads(dashboard_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return ""

    templating = dashboard.get("templating", {})
    variables = templating.get("list", [])
    for variable in variables:
        if variable.get("name") != variable_name:
            continue

        current = variable.get("current", {})
        value = current.get("value", "")
        if isinstance(value, list):
            value = value[0] if value else ""

        value = str(value).strip()
        if value in {"", "$__all", ".*", ".+"}:
            return ""
        return value

    return ""


def _template_name_for(filename: str) -> str:
    for template_name in TEMPLATE_DASHBOARDS:
        template_path = Path(template_name)
        stem = template_path.stem
        suffix = template_path.suffix

        if filename == template_name:
            return template_name
        if filename.startswith(f"{stem}__") and filename.endswith(suffix):
            return template_name

    return ""


def main() -> int:
    parser = argparse.ArgumentParser(
        description=(
            "Regenerate every existing project dashboard from templates while preserving "
            "locked/default variables such as project and VPS."
        )
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parents[1]
    projects_root = repo_root / "central" / "dashboards" / "projects"

    if not projects_root.is_dir():
        print(f"error: projects dir not found: {projects_root}", file=sys.stderr)
        return 2

    dashboard_files = sorted(
        path for path in projects_root.rglob("*.json")
        if path.parent.name != "_all" and not any(part.startswith(".") for part in path.parts)
    )

    if not dashboard_files:
        print("No project dashboards found under central/dashboards/projects.")
        return 0

    seen_projects: set[str] = set()
    for dashboard_path in dashboard_files:
        if not _template_name_for(dashboard_path.name):
            continue

        project = _read_variable_value(dashboard_path, "project") or dashboard_path.parent.name
        if project in seen_projects:
            continue

        vps = _read_variable_value(dashboard_path, "vps")

        result = generate_project_dashboards(project, vps=vps, overwrite=True)
        if result != 0:
            return result

        seen_projects.add(project)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
