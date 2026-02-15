#!/bin/bash
# OpenClaw Auto-Pilot Skill Pack - Installation Script
# Version: 1.0.0

set -e

echo "🜁 OpenClaw Auto-Pilot Skill Pack Installer"
echo "==========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
SKILL_PACK_DIR="${HOME}/.openclaw/skills/openclaw-auto-pilot-pack"
BACKUP_DIR="${HOME}/.openclaw/skills/.backup-$(date +%Y%m%d-%H%M%S)"

# Functions
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check prerequisites
echo "📋 Checking prerequisites..."

if ! command -v git &> /dev/null; then
    print_error "git is required but not installed"
    exit 1
fi

if ! command -v node &> /dev/null; then
    print_warning "Node.js not found. Some skills may not work."
fi

if ! command -v python3 &> /dev/null; then
    print_warning "Python 3 not found. Some skills may not work."
fi

print_status "Prerequisites check complete"
echo ""

# Create backup if exists
if [ -d "$SKILL_PACK_DIR" ]; then
    print_warning "Existing installation found. Creating backup..."
    mkdir -p "$BACKUP_DIR"
    cp -r "$SKILL_PACK_DIR" "$BACKUP_DIR/"
    print_status "Backup created at $BACKUP_DIR"
fi

# Create skill directory
echo "📁 Creating skill directory..."
mkdir -p "$SKILL_PACK_DIR"
cd "$SKILL_PACK_DIR"
print_status "Directory created: $SKILL_PACK_DIR"
echo ""

# Clone repository
echo "📥 Cloning skill pack repository..."
if [ ! -d ".git" ]; then
    git clone --recursive https://github.com/Charpup/openclaw-auto-pilot-pack.git .
fi
print_status "Repository cloned"
echo ""

# Initialize submodules
echo "🔧 Initializing skill submodules..."
git submodule update --init --recursive
print_status "Submodules initialized"
echo ""

# Install Node.js skills
echo "📦 Installing Node.js skills..."

if [ -d "skills/docs-rag" ]; then
    echo "  Installing docs-rag..."
    cd skills/docs-rag
    npm install 2>/dev/null || print_warning "docs-rag npm install had issues"
    cd ../..
    print_status "docs-rag installed"
fi

echo ""

# Install Python skills
echo "📦 Installing Python skills..."

if [ -d "skills/task-workflow" ]; then
    echo "  Installing task-workflow..."
    cd skills/task-workflow
    pip3 install -r requirements.txt 2>/dev/null || print_warning "task-workflow pip install had issues"
    cd ../..
    print_status "task-workflow installed"
fi

if [ -d "skills/config-validator" ]; then
    echo "  Installing config-validator..."
    cd skills/config-validator
    chmod +x scripts/*.sh 2>/dev/null || true
    cd ../..
    print_status "config-validator installed"
fi

echo ""

# Install planning-with-files
echo "📦 Installing planning-with-files..."
if [ ! -d "skills/planning-with-files" ]; then
    git clone https://github.com/OthmanAdi/planning-with-files.git skills/planning-with-files
fi
print_status "planning-with-files installed"
echo ""

# Create symlinks for easy access
echo "🔗 Creating symlinks..."
mkdir -p "${HOME}/.openclaw/skills"
ln -sf "$SKILL_PACK_DIR" "${HOME}/.openclaw/skills/auto-pilot-pack"
print_status "Symlinks created"
echo ""

# Verification
echo "🔍 Verifying installation..."

SKILL_COUNT=0
[ -d "skills/docs-rag" ] && ((SKILL_COUNT++))
[ -d "skills/task-workflow" ] && ((SKILL_COUNT++))
[ -d "skills/planning-with-files" ] && ((SKILL_COUNT++))
[ -d "skills/tdd-sdd-development" ] && ((SKILL_COUNT++))
[ -d "skills/config-validator" ] && ((SKILL_COUNT++))

if [ $SKILL_COUNT -eq 5 ]; then
    print_status "All 5 skills installed successfully!"
else
    print_warning "Only $SKILL_COUNT/5 skills installed. Check output above."
fi

echo ""
echo "==========================================="
echo "✅ Installation Complete!"
echo ""
echo "Next steps:"
echo "  1. Read the README: cat $SKILL_PACK_DIR/README.md"
echo "  2. Check out examples: ls $SKILL_PACK_DIR/examples/"
echo "  3. Start developing with: cd $SKILL_PACK_DIR"
echo ""
echo "Quick start:"
echo "  cd $SKILL_PACK_DIR/skills/docs-rag && ./query-docs.sh 'hello world'"
echo ""
echo "🜁 Happy auto-pilot development!"
