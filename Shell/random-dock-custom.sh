#!/bin/bash

### 🚀 RANDOMIZE DOCK ###
echo "Generating a completely random Dock..."

# Install dockutil if not installed
if ! command -v dockutil &> /dev/null; then
    echo "dockutil not found. Installing via Homebrew..."
    brew install dockutil
fi

# Remove all existing dock items
dockutil --remove all --no-restart

# Get a list of installed apps
INSTALLED_APPS=($(find /Applications -maxdepth 2 -name "*.app" -type d))

# Shuffle the app list and select up to 10 random apps
shuffled_apps=($(printf "%s\n" "${INSTALLED_APPS[@]}" | shuf -n 10))

# Add random apps to the Dock
for app in "${shuffled_apps[@]}"; do
    dockutil --add "$app" --no-restart
    echo "Added $(basename "$app") to Dock."
done

# Randomly move the Dock (bottom, left, right)
DOCK_POSITIONS=("bottom" "left" "right")
RANDOM_POSITION=${DOCK_POSITIONS[$RANDOM % ${#DOCK_POSITIONS[@]}]}
defaults write com.apple.dock orientation -string "$RANDOM_POSITION"
echo "Dock moved to $RANDOM_POSITION."

# Randomly set Dock size (between 16 and 128)
RANDOM_SIZE=$((16 + RANDOM % 113))
defaults write com.apple.dock tilesize -int "$RANDOM_SIZE"
echo "Dock size set to $RANDOM_SIZE."

# Randomly enable/disable magnification
MAGNIFICATION_VALUES=("true" "false")
RANDOM_MAGNIFICATION=${MAGNIFICATION_VALUES[$RANDOM % 2]}
defaults write com.apple.dock magnification -bool "$RANDOM_MAGNIFICATION"
echo "Dock magnification set to $RANDOM_MAGNIFICATION."

# Restart Dock to apply changes
killall Dock
echo "New completely random Dock created."

### 🖼️ CHANGE WALLPAPER ###
WALLPAPER_PATH="/System/Library/Desktop Pictures/City Lights.heic"
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$WALLPAPER_PATH\""
echo "Wallpaper changed to an architecture-themed wallpaper."

### 🏗️ SETUP ARCHITECT DESKTOP ###
CURRENT_DIR=~/Desktop

# Define folders for an architect
FOLDERS=(
    "Blueprints" "3D_Models" "Construction_Projects" "Project_Proposals"
    "Sketches" "Client_Meetings" "Material_References"
)

# Define files for architecture
FILES=(
    "Building_Design_Proposal.docx" "3D_Render_Skyscraper.dwg" "Interior_Design_Plan.pdf"
    "Structural_Calculations.xlsx" "Client_Project_Notes.txt" "Site_Inspection_Report.docx"
    "Floor_Plan_House.pdf" "Construction_Material_List.xlsx"
    "Facade_Design_Sketch.jpg" "Architectural_Drawing_AutoCAD.dwg"
)

# Define app shortcuts
APPS=(
    "/Applications/AutoCAD.app"
    "/Applications/SketchUp.app"
    "/Applications/Adobe Photoshop.app"
    "/Applications/Google Chrome.app"
    "/Applications/Numbers.app"
    "/Applications/Microsoft Word.app"
)

# Create folders
for folder in "${FOLDERS[@]}"; do
    mkdir -p "$CURRENT_DIR/$folder"
done

# Create architecture-related files on the Desktop
for ((i = 1; i <= 20; i++)); do
    FILE="${FILES[$i % ${#FILES[@]}]}"  # Cycle through file list
    touch "$CURRENT_DIR/$FILE"
done

# Distribute files into folders
for folder in "${FOLDERS[@]}"; do
    NUM_FILES=$(( RANDOM % 3 + 3 )) # Random number between 3 and 5 files per folder
    for ((i = 1; i <= NUM_FILES; i++)); do
        FILE="${FILES[$RANDOM % ${#FILES[@]}]}"  # Random file selection
        touch "$CURRENT_DIR/$folder/$FILE"
    done
done

# Create app shortcuts on the Desktop
for app in "${APPS[@]}"; do
    if [ -d "$app" ]; then
        ln -s "$app" "$CURRENT_DIR/$(basename "$app" .app)"
    fi
done

# Restart Finder
killall Finder

echo "✅ Architect's desktop environment created at: $CURRENT_DIR"
