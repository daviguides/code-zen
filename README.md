# Code Zen

 [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> Philosophy-driven coding standards for multiple languages, designed as a Claude Code plugin.

<img src="images/code-zen-banner.png" alt="Diagram" align="right" style="width: 500px"/>

## What is Code Zen?

Code Zen is a collection of **language-agnostic** and **language-specific** coding guidelines that help you write clear, maintainable code following zen-like principles:

- **Clarity over cleverness**
- **Readability first**
- **Single responsibility**
- **Explicit over implicit**

## Quick Start

### One-Line Installation

Install Code Zen directly from GitHub (recommended):

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/daviguides/code-zen/main/install.sh)"
```

The installer will:
1. Clone the latest version from GitHub
2. Copy `zen-code-standards/` to `~/.claude/zen-code-standards/`
3. Optionally configure `~/.claude/CLAUDE.md`
4. Clean up temporary files automatically

### Manual Installation

If you prefer manual setup:

```bash
# Clone repository
git clone https://github.com/daviguides/code-zen.git
cd code-zen

# Copy standards
cp -r zen-code-standards ~/.claude/

# Add to ~/.claude/CLAUDE.md
cat >> ~/.claude/CLAUDE.md << 'EOF'

# Project Coding Standards

## Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply
EOF
```

## Usage

Code Zen can be used in two ways: as **automatic standards** via CLAUDE.md or as a **Claude Code plugin** with interactive commands.

### Option 1: Automatic Standards (Recommended for Projects)

Once installed globally, reference Code Zen in any project's `CLAUDE.md`:

```markdown
# Project Coding Standards

## Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply

## Project Overrides
<!-- Add project-specific overrides here -->
```

See [claude-plug-in-sample.md](./claude-plug-in-sample.md) for detailed examples.

### Option 2: Plugin Commands (Interactive Usage)

Code Zen also provides interactive commands and specialized agents:

#### Available Commands

Load context for your session:
```bash
/load-zen-context        # Load Zen of Python principles
/load-python-context     # Load Python-specific standards
```

Analyze and improve code:
```bash
/zen-check              # Check code compliance with Zen principles
/zen-refactor           # Refactor code following Zen principles
```

#### Specialized Agents

Code Zen includes agents that activate automatically:

- **zen-reviewer** - Code review specialist focused on Zen principles
- **python-zen-expert** - Python development specialist with modern best practices

These agents provide context-aware assistance during development, code reviews, and refactoring.

### Hybrid Approach (Best of Both)

For maximum benefit, use both:

1. **Global installation** for automatic standards in all projects
2. **Plugin commands** for interactive checks and refactoring
3. **Agents** for specialized assistance

```bash
# 1. Install standards globally
sh -c "$(curl -fsSL https://raw.githubusercontent.com/daviguides/code-zen/main/install.sh)"

# 2. Use commands as needed
/load-zen-context
/zen-check
/zen-refactor
```

## Structure

```
code-zen/
├── .claude-plugin/
│   └── plugin.json           # Plugin metadata
├── commands/                 # Interactive commands
│   ├── load-zen-context.md
│   ├── load-python-context.md
│   ├── zen-check.md
│   └── zen-refactor.md
├── agents/                   # Specialized agents
│   ├── zen-reviewer.md
│   └── python-zen-expert.md
├── zen-code-standards/       # Standards library
│   ├── coding-standards.md  # Entry point
│   ├── universal/           # Language-agnostic principles
│   │   ├── general_coding_principles.md
│   │   └── project_setup_guidelines.md
│   ├── python/              # Python-specific guidelines
│   │   ├── python_quick_reference.md
│   │   ├── python_library_preferences.md
│   │   ├── tdd_optimized_guidelines.md
│   │   └── zen_of_python/
│   │       ├── zen_quick_reference.md
│   │       ├── zen_guideline_llm.md
│   │       └── zen_theory_explained.md
│   └── other_rules/
│       └── file-references-guideline.md
├── docs/                     # Documentation site
├── install.sh               # One-line installer
└── README.md
```

## Supported Languages

- ✅ **Python** - Complete guidelines including Zen of Python
- 🚧 **Rust** - Coming soon
- 🚧 **Go** - Coming soon

## Philosophy

Code Zen is built on timeless principles:

### Universal Principles
- Write code in English
- Prioritize clarity and readability
- Single Responsibility Principle
- Avoid magic numbers/strings
- Errors should never pass silently

### Python Zen
- Beautiful is better than ugly
- Explicit is better than implicit
- Simple is better than complex
- Readability counts

See [universal/general_coding_principles.md](./zen-code-standards/universal/general_coding_principles.md) for complete guidelines.

## Contributing

Contributions welcome! To add support for a new language:

1. Create `zen-code-standards/<language>/` directory
2. Add language-specific guidelines
3. Update `coding-standards.md` to reference new language
4. Submit PR

## License

MIT License - See [LICENSE](./LICENSE) for details

## Author

Philosophy-driven code standards for Claude Code
