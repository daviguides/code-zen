# Load Python Standards Workflow

Load complete Python coding standards and best practices for this session.

## Language Specifications

@../spec/python/python-language-spec.md
@../spec/python/python-style-spec.md
@../spec/python/python-libraries-spec.md

## Zen Principles

@../spec/principles/zen-principles-spec.md

## Universal Standards

@../spec/universal/naming-conventions-spec.md
@../spec/universal/code-structure-spec.md
@../spec/universal/error-handling-spec.md

## Quick Reference

@../context/guides/python-quick-guide.md

## Code Templates

@../context/examples/python-templates.md
@../context/examples/python-patterns.md

## Anti-Patterns

@../context/examples/python-anti-patterns.md

## Validation

@../context/checklists/pre-code-checklist.md
@../context/checklists/review-checklist.md

## Key Requirements

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
