#!/bin/bash

# Color definitions
GREEN='\033[0;32m'
NC='\033[0m' # No color

echo -e "${GREEN}> Flutter Clean${NC}"
flutter clean

echo -e "${GREEN}> Getting Flutter packages${NC}"
flutter pub get

echo -e "${GREEN}> Running Build Runner${NC}"
# Automatically select 1 for deleting files and color the output
yes 1 | dart pub run build_runner build --delete-conflicting-outputs

echo -e "${GREEN}> Getting Flutter packages${NC}"
flutter pub get