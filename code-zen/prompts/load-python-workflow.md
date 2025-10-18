# Load Python Standards Workflow

Load Python-specific coding standards and best practices.

## Python Language Specifications

@~/.claude/code-zen/spec/python/python-language-spec.md
@~/.claude/code-zen/spec/python/python-style-spec.md
@~/.claude/code-zen/spec/python/python-libraries-spec.md
@~/.claude/code-zen/spec/python/python-tdd-spec.md

## Python Quick Reference

@~/.claude/code-zen/context/guides/python-quick-guide.md

## Python Code Resources

@~/.claude/code-zen/context/examples/python-templates.md
@~/.claude/code-zen/context/examples/python-patterns.md
@~/.claude/code-zen/context/examples/python-anti-patterns.md

## Key Python Requirements

**Python Version:**
- Python ≥ 3.13 always
- No `__future__` imports
- Modern syntax (`list[str]` not `List[str]`)

**Type System:**
- Type hints mandatory on all functions
- Use Python 3.13+ native syntax
- Union types with `|` not `Union`

**Style:**
- **80 columns maximum** (strict)
- Ruff for formatting
- f-strings always
- Trailing commas

**Imports:**
- pathlib over os.path
- 3 groups: stdlib, third-party, local
- Blank lines between groups

**Function Calls:**
- kwargs for multiple arguments
- Multiple lines for +1 argument
- Trailing commas

**Error Handling:**
- Never silent (unless explicitly intended)
- Specific exception types
- Exception chaining with `from e`

**Workflow:**
1. Check pre-code checklist before writing
2. Use appropriate templates
3. Follow patterns and avoid anti-patterns
4. Verify with review checklist after writing

Apply these Python standards to ALL code in this session.
