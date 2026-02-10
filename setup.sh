#!/usr/bin/env bash
set -euo pipefail

echo "=== Zig-Zag Path Survival – Setup ==="

if ! command -v flutter >/dev/null 2>&1; then
  echo "Error: Flutter SDK not found in PATH."
  echo "Please install Flutter and ensure 'flutter' is available, then re-run this script."
  exit 1
fi

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

echo "-> Running 'flutter pub get'..."
flutter pub get

echo "-> Running 'flutter analyze' (if project is already initialized)..."
if [ -f "pubspec.yaml" ]; then
  flutter analyze || echo "Warning: 'flutter analyze' reported issues. Please review above output."
else
  echo "No pubspec.yaml found yet. Initialize the Flutter project before running analysis."
fi

echo "-> Running 'flutter test' (if tests exist)..."
if [ -d "test" ]; then
  if ls test/*.dart >/dev/null 2>&1; then
    flutter test || echo "Warning: 'flutter test' failed. Please review above output."
  else
    echo "No Dart test files found under 'test/'. Skipping tests."
  fi
else
  echo "No 'test/' directory found. Skipping tests."
fi

echo "=== Setup complete (see warnings above, if any). ==="

