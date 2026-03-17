#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from new_project_dashboards import generate_project_dashboards


def _read_locked_variable(dashboard_path: Path, variable_name: str) -> str:
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
            return str(value[0]).strip() if value else ""
        return str(value).strip()

    return ""


def main() -> int:
    parser = argparse.ArgumentParser(
        description=(
            "Regenerate every existing project dashboard folder from templates while"
            " preserving locked variables such as project and VPS."
        )
    )
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parents[1]
    projects_root = repo_root / "central" / "dashboards" / "projects"

    if not projects_root.is_dir():
        print(f"error: projects dir not found: {projects_root}", file=sys.stderr)
        return 2

    project_dirs = sorted(
        path for path in projects_root.iterdir()
        if path.is_dir() and path.name != "_all" and not path.name.startswith(".")
    )

    if not project_dirs:
        print("No project folders found under central/dashboards/projects.")
        return 0

    for project_dir in project_dirs:
        project = project_dir.name
        system_dashboard = project_dir / "system_monitoring.json"
        locked_vps = _read_locked_variable(system_dashboard, "vps")

        result = generate_project_dashboards(project, vps=locked_vps, overwrite=True)
        if result != 0:
            return result

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
