#!/bin/bash

# Define the directories
WEB_DIR="web/"
DOCS_DIR="docs/"

# Build the web project
echo "Building the Flutter web project..."
flutter build web --release --base-href "/translation-invoice-calculator/"

# Move the built files to the docs folder
echo "Moving the built files to the docs folder..."
rm -rf docs
mkdir docs
cp -r build/web/* docs

echo "Done!"