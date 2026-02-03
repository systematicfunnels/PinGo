#!/bin/bash
set -e

echo "🔍 Running Quality Checks..."

echo "--------------------------------------------------"
echo "1️⃣  Formatting..."
dart format --output=none --set-exit-if-changed .

echo "--------------------------------------------------"
echo "2️⃣  Analyzing..."
flutter analyze

echo "--------------------------------------------------"
echo "3️⃣  Testing..."
flutter test

echo "--------------------------------------------------"
echo "✅ All checks passed!"
