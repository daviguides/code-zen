# Code Zen - Philosophy-driven Coding Standards

Claude Code plugin providing universal and language-specific coding guidelines.

## Project Coding Standards

### Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply

### Project Overrides

#### Documentation Standards
- All markdown files must be clear and follow project structure
- README.md must explain installation and usage
- Each language folder must have quick reference guides

#### Script Standards (Bash)
- Shell scripts must be POSIX-compliant when possible
- Use clear error messages with color coding
- Always cleanup temporary files
- Provide user confirmation for destructive operations

#### Plugin Architecture
- Use `@./path` syntax for file references
- Maintain clear separation: universal/ and language-specific folders
- Entry point must be coding-standards.md
