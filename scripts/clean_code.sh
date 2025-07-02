#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No color

echo -e "${GREEN}> 📦 Getting Flutter packages...${NC}"
flutter pub get || { echo -e "${RED}>❌  Failed to get packages. Exiting.${NC}"; exit 1; }

echo -e "${GREEN}> 🔍 Running dart fix (auto-removes unused imports)...${NC}"
dart fix --apply

echo -e "${GREEN}> 🎯 Formatting Dart files with 2-space indentation...${NC}"
dart format . --line-length 80

echo -e "🧪 Running flutter analyze to check for remaining issues...${NC}"
flutter analyze || { echo -e "${RED}> ❌  flutter analyze failed. Exiting.${NC}"; exit 1; }

echo -e "${GREEN}> ✅  Code cleanup complete!${NC}"