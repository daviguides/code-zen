# Zen Code Validation Workflow

Validate code against Zen of Python principles and coding standards.

## Validation Checklists

@../context/checklists/review-checklist.md
@../context/checklists/pre-code-checklist.md

## Zen Principles Reference

@../spec/principles/zen-principles-spec.md

## Standards to Validate

@../spec/python/python-language-spec.md
@../spec/python/python-style-spec.md
@../spec/universal/naming-conventions-spec.md
@../spec/universal/code-structure-spec.md
@../spec/universal/error-handling-spec.md

## Anti-Patterns to Detect

@../context/examples/python-anti-patterns.md

## Validation Process

### Phase 1: Automated Checks

**Beautiful (PEP 8):**
- Line length ≤ 80 characters
- Proper indentation (4 spaces)
- Naming conventions (snake_case, PascalCase, UPPER_SNAKE_CASE)
- Import organization (3 groups with blank lines)
- Whitespace around operators

**Type System:**
- All function parameters have type hints
- All return types annotated
- Python 3.13+ syntax used
- No `List`, `Dict` - use `list`, `dict`
- Union types use `|` not `Union`

**Style:**
- F-strings used (not % or .format())
- pathlib used (not os.path)
- Trailing commas in multi-line constructs
- kwargs for multiple arguments

### Phase 2: Zen Principles Check

**Explicit > Implicit:**
- No implicit defaults (e.g., `db = db or get_default()`)
- All behaviors are obvious
- No hidden side effects

**Simple > Complex:**
- Solution matches problem complexity
- No over-engineering
- Functions have single responsibility

**Flat > Nested:**
- Maximum 3 levels of indentation
- Guard clauses used
- Early returns implemented

**Readability:**
- Functions explainable in one sentence
- Descriptive names
- No magic numbers
- Clear logic flow

**Errors Never Silent:**
- No bare `except:`
- Specific exception types
- Error messages with context
- Exception chaining used

### Phase 3: Anti-Pattern Detection

**Check for:**
- Magic numbers/strings
- Deep nesting (arrow anti-pattern)
- Implicit behavior
- Silent failures
- Cryptic names
- Dense one-liners
- Missing type hints
- Missing docstrings

### Phase 4: Severity Classification

**High Severity (Fix Immediately):**
- Silent error handling
- Missing type hints
- Deep nesting > 3 levels
- Missing input validation
- Functions > 100 lines

**Medium Severity (Fix Soon):**
- PEP 8 violations
- Unclear naming
- Magic numbers
- Missing docstrings
- Old Python syntax

**Low Severity (Nice to Have):**
- Missing trailing commas
- Import organization
- Minor style issues

## Validation Output

Provide structured feedback:

1. **Summary:** Overall compliance status
2. **High Severity Issues:** List with file:line references
3. **Medium Severity Issues:** List with file:line references
4. **Low Severity Issues:** List with file:line references
5. **Positive Findings:** What's done well
6. **Recommendations:** Prioritized fixes

## Approval Criteria

Code PASSES validation only if:
- ✅ No high severity issues
- ✅ All Zen principles followed
- ✅ Type hints on all functions
- ✅ Proper error handling
- ✅ ≤ 80 column width
- ✅ No anti-patterns detected
