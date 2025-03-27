#!/usr/bin/env bash

# Resume Live Editing Workflow Script
# Usage: ./scripts/resume-live-edit.sh

cwd ..

# Set terminal colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}LaTeX Resume Live Editing Workflow${NC}"
echo -e "${BLUE}========================================${NC}"

# Check for PDF viewer
PDF_VIEWER="evince"

# Check if resume.tex exists
if [ ! -f "resume.tex" ]; then
    echo -e "❌ ${YELLOW}resume.tex${NC} not found in current directory."
    exit 1
fi

# Create build directory if it doesn't exist
mkdir -p build

# Start PDF viewer if available
if [ -n "$PDF_VIEWER" ]; then
    echo -e "\n${YELLOW}Starting PDF viewer...${NC}"
    if [ -f "./build/resume.pdf" ]; then
        $PDF_VIEWER ./build/resume.pdf &> /dev/null &
    else
        echo -e "🔄 PDF not found yet. Will open when first compiled."
    fi
fi

# Setup initial build
echo -e "\n${YELLOW}Building initial PDF...${NC}"
latexmk -outdir=build -pdf resume.tex

# Ensure the PDF viewer is showing the PDF after initial build
if [ -n "$PDF_VIEWER" ] && [ ! -f "./build/resume.pdf" ]; then
    $PDF_VIEWER ./build/resume.pdf &> /dev/null &
fi

# Start watching for changes
echo -e "\n${YELLOW}Watching for changes to${NC} resume.tex"
echo -e "${GREEN}Edit your resume and see changes reflected instantly!${NC}"
echo -e "${BLUE}Press Ctrl+C to stop watching.${NC}\n"

# Watch the file and rebuild on changes
while true; do
    find resume.tex | entr -d sh -c "echo -e '${YELLOW}File changed. Rebuilding...${NC}' && latexmk -outdir=build -pdf resume.tex && echo -e '${GREEN}Done!${NC}'"

    # Exit code 130 indicates SIGINT (Ctrl+C)
    if [ $? -eq 130 ]; then
        echo -e "\n${GREEN}Live editing stopped.${NC}"
        break
    fi
done
