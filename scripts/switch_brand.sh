#!/usr/bin/env bash

# Simple branding switcher for this project.
# Usage:
#   ./scripts/switch_brand.sh academic
#   ./scripts/switch_brand.sh imam
#
# NOTE:
# - Backend domain / API base URL and package name stay the same.
# - This script only toggles visible branding (app name, colors, icons config).
# - Adjust the values below (labels, colors, icon paths) to your exact designs.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BRAND="${1:-}"
if [[ -z "$BRAND" ]]; then
  echo "Usage: $0 {academic|imam}"
  exit 1
fi

ANDROID_MANIFEST="$ROOT_DIR/android/app/src/main/AndroidManifest.xml"
PUBSPEC="$ROOT_DIR/pubspec.yaml"
STYLES="$ROOT_DIR/android/app/src/main/res/values/styles.xml"
COLORS="$ROOT_DIR/android/app/src/main/res/values/colors.xml"

if [[ ! -f "$ANDROID_MANIFEST" ]] || [[ ! -f "$PUBSPEC" ]]; then
  echo "Run this script from inside the project repo. Files not found."
  exit 1
fi

# --- Current known values in the project ---

# Android label (launcher name under icon)
IMAM_LABEL='دانشگاه امام صادق (ع)'
ACADEMIC_LABEL='Academic'

# Primary / brand color (used in styles.xml + launcher background)
# You can update these hex codes to your desired palette.
IMAM_PRIMARY_COLOR='#3BA5B8'
ACADEMIC_PRIMARY_COLOR='#3BA5B8'

# Launcher icon asset paths from pubspec.yaml
# فعلاً هر دو برند از یک لوگو استفاده می‌کنند تا تنظیم راحت باشد.
# اگر بعداً لوگوی جدا ساختی، فقط این دو مقدار را عوض کن.
IMAM_ICON_PATH='assets/ic_logo.png'
ACADEMIC_ICON_PATH='assets/ic_logo.png'

echo "Switching branding to: $BRAND"

sed_inplace() {
  # macOS/BSD vs GNU sed compatibility
  if sed --version >/dev/null 2>&1; then
    sed -i "$@"
  else
    sed -i '' "$@"
  fi
}

case "$BRAND" in
  academic)
    echo "  • Updating Android label to Academic..."
    sed_inplace "s|android:label=\"$IMAM_LABEL\"|android:label=\"$ACADEMIC_LABEL\"|g" "$ANDROID_MANIFEST"

    echo "  • Updating primary color to Academic..."
    sed_inplace "s|<color name=\"primaryColor\">$IMAM_PRIMARY_COLOR</color>|<color name=\"primaryColor\">$ACADEMIC_PRIMARY_COLOR</color>|g" "$STYLES"
    sed_inplace "s|<color name=\"ic_launcher_background\">$IMAM_PRIMARY_COLOR</color>|<color name=\"ic_launcher_background\">$ACADEMIC_PRIMARY_COLOR</color>|g" "$COLORS"

    echo "  • (Icon paths یکسان هستند؛ تغییر داده نمی‌شود.)"
    ;;

  imam)
    echo "  • Updating Android label to دانشگاه امام صادق (ع)..."
    sed_inplace "s|android:label=\"$ACADEMIC_LABEL\"|android:label=\"$IMAM_LABEL\"|g" "$ANDROID_MANIFEST"

    echo "  • Updating primary color to Imam Sadegh branding..."
    sed_inplace "s|<color name=\"primaryColor\">$ACADEMIC_PRIMARY_COLOR</color>|<color name=\"primaryColor\">$IMAM_PRIMARY_COLOR</color>|g" "$STYLES"
    sed_inplace "s|<color name=\"ic_launcher_background\">$ACADEMIC_PRIMARY_COLOR</color>|<color name=\"ic_launcher_background\">$IMAM_PRIMARY_COLOR</color>|g" "$COLORS"

    echo "  • (Icon paths یکسان هستند؛ تغییر داده نمی‌شود.)"
    ;;

  *)
    echo "Unknown brand: $BRAND"
    echo "Valid options: academic, imam"
    exit 1
    ;;
esac

echo "Done. If you changed icon paths, run:"
echo "  flutter pub run flutter_launcher_icons"

