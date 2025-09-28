#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/daviguides/code-zen.git"
TMP_DIR="/tmp/code-zen-$$"
CLAUDE_DIR="$HOME/.claude"
TARGET_DIR="$CLAUDE_DIR/zen-code-standards"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"

# Cleanup function
cleanup() {
    if [ -d "$TMP_DIR" ]; then
        echo -e "${BLUE}Cleaning up temporary files...${NC}"
        rm -rf "$TMP_DIR"
    fi
}

# Set trap to cleanup on exit
trap cleanup EXIT

echo -e "${BLUE}Code Zen Installer${NC}"
echo -e "${BLUE}==================${NC}\n"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    echo "Please install git first: https://git-scm.com/downloads"
    exit 1
fi

# Clone repository
echo -e "${BLUE}Cloning Code Zen repository...${NC}"
if ! git clone --quiet "$REPO_URL" "$TMP_DIR" 2>/dev/null; then
    echo -e "${RED}Error: Failed to clone repository${NC}"
    echo "Repository: $REPO_URL"
    exit 1
fi
echo -e "${GREEN}✓ Repository cloned successfully${NC}\n"

# Check if ~/.claude exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${YELLOW}Creating ~/.claude directory...${NC}"
    mkdir -p "$CLAUDE_DIR"
fi

# Copy zen-code-standards folder
echo -e "${BLUE}Installing zen-code-standards to $TARGET_DIR...${NC}"
if [ -d "$TARGET_DIR" ]; then
    read -p "Directory $TARGET_DIR already exists. Overwrite? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$TARGET_DIR"
    else
        echo -e "${YELLOW}Installation cancelled.${NC}"
        exit 0
    fi
fi

cp -r "$TMP_DIR/zen-code-standards" "$TARGET_DIR"
echo -e "${GREEN}✓ zen-code-standards installed successfully!${NC}\n"

# Extract SAMPLE_CONFIG from claude-plug-in-sample.md
echo -e "${BLUE}Reading configuration template...${NC}"
SAMPLE_CONFIG=$(sed -n '3,12p' "$TMP_DIR/claude-plug-in-sample.md")

if [ -z "$SAMPLE_CONFIG" ]; then
    echo -e "${RED}Error: Failed to extract SAMPLE_CONFIG${NC}"
    exit 1
fi

# Handle CLAUDE.md configuration
if [ ! -f "$CLAUDE_MD" ]; then
    echo -e "${BLUE}No CLAUDE.md found in ~/.claude/${NC}"
    read -p "Create ~/.claude/CLAUDE.md with Code Zen configuration? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "$SAMPLE_CONFIG" > "$CLAUDE_MD"
        echo -e "${GREEN}✓ CLAUDE.md created successfully!${NC}\n"
    else
        echo -e "${YELLOW}Skipped CLAUDE.md creation.${NC}"
        echo -e "${YELLOW}To use Code Zen, add this to your ~/.claude/CLAUDE.md:${NC}\n"
        echo "$SAMPLE_CONFIG"
        echo
    fi
else
    echo -e "${YELLOW}~/.claude/CLAUDE.md already exists.${NC}"
    read -p "Append Code Zen configuration to existing CLAUDE.md? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Check if already configured
        if grep -q "zen-code-standards" "$CLAUDE_MD"; then
            echo -e "${YELLOW}Code Zen already configured in CLAUDE.md${NC}"
        else
            echo -e "\n\n$SAMPLE_CONFIG" >> "$CLAUDE_MD"
            echo -e "${GREEN}✓ Code Zen configuration added to CLAUDE.md${NC}\n"
        fi
    else
        echo -e "${YELLOW}Skipped CLAUDE.md modification.${NC}"
        echo -e "${YELLOW}To use Code Zen, add this to your ~/.claude/CLAUDE.md:${NC}\n"
        echo "$SAMPLE_CONFIG"
        echo
    fi
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "\n${BLUE}Next steps:${NC}"
echo "1. Check ~/.claude/CLAUDE.md to ensure configuration is correct"
echo "2. Use Code Zen in any project by referencing it in project CLAUDE.md"
echo "3. See https://github.com/daviguides/code-zen for usage examples"
echo -e "\n${BLUE}Documentation:${NC} https://github.com/daviguides/code-zen"
