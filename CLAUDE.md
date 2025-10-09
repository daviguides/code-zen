# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Code Zen is a **Claude Code plugin** providing philosophy-driven coding standards for multiple programming languages. It's designed to be installed globally in `~/.claude/` and referenced from project-level CLAUDE.md files.

## Architecture

### Core Components

1. **zen-code-standards/** - Distributable standards directory
   - `coding-standards.md` - Entry point that references all standards
   - `universal/` - Language-agnostic principles
   - `python/` - Python-specific guidelines (Zen of Python, TDD, type hints)
   - `other_rules/` - Meta guidelines (file references, etc)

2. **docs/** - Jekyll documentation site
   - Deployed to GitHub Pages automatically
   - References standards from zen-code-standards/

3. **install.sh** - One-line installer script
   - Clones repo to temp directory
   - Copies zen-code-standards/ to ~/.claude/
   - Optionally configures ~/.claude/CLAUDE.md

### File Reference System

Uses `@./path` syntax for cross-file references:
- `@./zen-code-standards/coding-standards.md` - References the entry point
- `@./universal/general_coding_principles.md` - References specific guidelines

This allows Claude Code to load referenced files automatically.

### Standards Hierarchy

```
User's Global CLAUDE.md (~/.claude/CLAUDE.md)
  ↓ INHERITS FROM
@./zen-code-standards/coding-standards.md
  ↓ REFERENCES
Universal principles + Language-specific guidelines
  ↓ CAN BE OVERRIDDEN BY
Project-specific CLAUDE.md (in individual projects)
```

## Development Commands

### Documentation Site

The docs are built with Jekyll and deployed to GitHub Pages:

```bash
# Serve docs locally (requires Ruby/Jekyll)
cd docs
bundle exec jekyll serve

# View at http://localhost:4000
```

Deployment is automatic via GitHub Actions when pushing to main branch.

### Testing Installation

```bash
# Test the installer locally
./install.sh

# Or via curl (as users would):
sh -c "$(curl -fsSL https://raw.githubusercontent.com/daviguides/code-zen/main/install.sh)"
```

The installer:
1. Clones repo to /tmp/code-zen-$$
2. Copies zen-code-standards/ to ~/.claude/
3. Optionally configures ~/.claude/CLAUDE.md
4. Cleans up temp files automatically

### Structure Validation

```bash
# Verify all referenced files exist
grep -r "@\\./" zen-code-standards/ --include="*.md"

# Check markdown links
find zen-code-standards -name "*.md" -exec grep -H "\[.*\](.*)" {} \;
```

## Key Design Principles

### Plugin vs CLAUDE.md Philosophy

**This is NOT a traditional Claude Code plugin** (no .claude-plugin/plugin.json). Instead, it's a **distributable standards library** that users install globally and reference via CLAUDE.md.

**Why this approach:**
- Standards need to be automatically loaded (not manually activated via slash commands)
- CLAUDE.md provides automatic context injection that plugins cannot
- Users can override standards at project level
- Hierarchical inheritance: global → project

### Standards Organization

**Universal Standards** (zen-code-standards/universal/):
- Apply to ALL languages
- Core principles: clarity, readability, single responsibility
- Examples: naming conventions, error handling, DRY/KISS/YAGNI

**Language-Specific Standards** (zen-code-standards/python/):
- Python ≥ 3.13 modern syntax
- Zen of Python implementation guidelines
- TDD optimized for LLMs
- Type hints, library preferences

### File Reference Best Practices

When adding new standards:
1. Create the file in appropriate directory (universal/ or language/)
2. Add reference in zen-code-standards/coding-standards.md
3. Use `@./path` syntax for cross-references
4. Keep files focused (≤500 lines recommended)

## Documentation Standards

### Markdown Files

- Must be clear and well-structured
- Use headers for navigation
- Include code examples in fenced blocks
- Cross-reference related files using relative paths

### Code Examples

Show both ❌ anti-patterns and ✅ correct patterns:

```python
# ❌ ANTI-PATTERN
def calc(u, a):
    return a * 0.9 if u["premium"] else a

# ✅ CORRECT
def calculate_discounted_price(user: User, amount: Decimal) -> Decimal:
    """Calculate final price with user-specific discount."""
    if user.subscription_type == "premium":
        return amount * Decimal("0.90")
    return amount
```

## Project-Specific Guidelines

### Shell Scripts (install.sh)

- POSIX-compliant when possible
- Clear error messages with color coding
- Always cleanup temp files (use trap for EXIT)
- Provide user confirmation for destructive operations
- Set `set -e` to exit on errors

Example from install.sh:
```bash
# Cleanup function
cleanup() {
    if [ -d "$TMP_DIR" ]; then
        echo -e "${BLUE}Cleaning up temporary files...${NC}"
        rm -rf "$TMP_DIR"
    fi
}

# Set trap to cleanup on exit
trap cleanup EXIT
```

### Adding New Language Support

To add support for a new language (e.g., Rust, Go):

1. Create directory: `zen-code-standards/rust/`
2. Add language-specific guidelines following Python structure:
   - `rust_quick_reference.md` - Quick syntax reference
   - `rust_library_preferences.md` - Recommended libraries
   - Additional guideline files as needed
3. Update `zen-code-standards/coding-standards.md` to reference new files
4. Update README.md to mark language as supported
5. Consider adding docs/_pages/rust-standards.md for documentation site

### Documentation Site Updates

When adding new content:
1. Add markdown file to `docs/_pages/`
2. Update navigation in `docs/_data/navigation.yml` if needed
3. Use Jekyll front matter for metadata
4. Reference zen-code-standards/ files using relative paths

## Integration Notes

### For Users Installing Code Zen

Users reference these standards in their project CLAUDE.md:

```markdown
# Project Coding Standards

## Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply

## Project Overrides
<!-- Add project-specific overrides here -->
```

### For Developers Contributing

When modifying standards:
1. Ensure changes are backward compatible
2. Update version references if breaking changes
3. Test with sample projects that reference the standards
4. Update documentation site to reflect changes

## Distribution Model

**Global Installation:**
```bash
~/.claude/
  ├── CLAUDE.md                    # User's global config
  └── zen-code-standards/          # Installed by install.sh
      ├── coding-standards.md
      ├── universal/
      ├── python/
      └── other_rules/
```

**Project Usage:**
```
my-project/
  └── CLAUDE.md                     # References @./zen-code-standards/
```

This allows:
- Single source of truth for standards
- Easy updates (re-run installer)
- Project-level customization
- No need to copy standards to each project
