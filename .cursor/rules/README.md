# Cursor Rules for UI-Ready Projects

This package is built for Flutter projects where UI already exists. These rules will generate:
- API integration
- Models
- Cubits and States
- Repository methods
And then connect them to your pre-built pages and widgets.

## Included Rules

- `connect_api_to_existing_ui.mdc`: Adds Cubit + API call to existing login page
- `inject_existing_api_to_ui.mdc`: Injects logic into any existing page
- `generate_only_logic_layer.mdc`: Builds all backend logic for a feature (no UI)

## How to use

Put these files inside `.cursor/rules/` and run:
```bash
cursor do connect_api_to_existing_ui "login"
```