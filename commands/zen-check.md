---
description: Check code compliance with Zen of Python principles
---

Analyze the current code for Zen of Python compliance and provide detailed feedback.

## 🔍 Checks to Perform

### 1. Beautiful (PEP 8 Compliance)

Check for:
- **Line length** ≤ 80 characters
- **Indentation** using 4 spaces (not tabs)
- **Naming conventions**:
  - Functions/variables: `snake_case`
  - Classes: `PascalCase`
  - Constants: `UPPER_SNAKE_CASE`
- **Import organization**:
  - Group 1: Standard library
  - Group 2: Third-party packages
  - Group 3: Local imports
  - Blank lines between groups
- **Blank lines**:
  - 2 blank lines before top-level functions/classes
  - 1 blank line between methods
- **Whitespace** around operators and after commas

### 2. Explicit (Clear Intentions)

Check for:
- **Type hints** on all function parameters and return types
- **No implicit behavior**:
  - Avoid `db = db or get_default_db()`
  - Avoid truthiness checks where explicit is better
- **Clear parameter names** (no single letters except loop counters)
- **Docstrings** on all public functions and classes
- **No hidden side effects**
- **Explicit validation** at function start

### 3. Simple vs Complex

Check for:
- **Single Responsibility** - Each function does one thing
- **No over-engineering** - Solution matches problem complexity
- **Clear control flow** - Easy to follow logic
- **Minimal abstractions** - Only abstract when needed
- **Function length** - Generally < 50 lines

### 4. Flat vs Nested

Check for:
- **Nesting levels** - Maximum 3 levels of indentation
- **Guard clauses** instead of nested if statements
- **Early returns** to avoid deep nesting
- **No arrow anti-pattern** (multiple nested ifs forming "arrow")

Example of what to flag:
```python
# ❌ BAD - Deep nesting (arrow anti-pattern)
def process(user):
    if user:
        if user.is_active:
            if user.has_subscription:
                if user.subscription.is_valid():
                    return process_user(user)
```

Should suggest:
```python
# ✅ GOOD - Flat with guard clauses
def process(user: User | None) -> ProcessResult:
    """Process user with validation."""
    if not user:
        raise ValueError("User required")
    if not user.is_active:
        raise UserError("User inactive")
    if not user.has_subscription:
        raise SubscriptionError("No subscription")
    if not user.subscription.is_valid():
        raise InvalidSubscriptionError("Invalid subscription")

    return process_user(user)
```

### 5. Readability

Check for:
- **Can explain in 1 sentence** - Function purpose is clear
- **Variable names are descriptive**:
  - ✅ `user_discount_percentage`
  - ❌ `discount` or `d`
- **No magic numbers** - Use named constants
- **Comments explain WHY, not WHAT**
- **Code tells a story** - Natural flow from top to bottom
- **Boolean naming** - `is_active`, `has_permission`, `can_process`

### 6. Error Handling

Check for:
- **No silent failures**:
  - ❌ Bare `except:`
  - ❌ `except Exception: pass`
  - ❌ Returning `None` on error without raising
- **Specific exceptions** - Catch specific types, not generic `Exception`
- **Error context** - Error messages include helpful information
- **Exception chaining** - Use `raise ... from e`
- **Validation before operations** - Check inputs at function start

### 7. Python-Specific

Check for:
- **Type hints** using Python 3.13+ syntax:
  - ✅ `list[str]`, `dict[str, int]`
  - ❌ `List[str]`, `Dict[str, int]`
- **f-strings** for formatting (not `%` or `.format()`)
- **pathlib** for file operations (not `os.path`)
- **Trailing commas** in multi-line signatures
- **kwargs** for function calls with multiple arguments

## 📊 Output Format

For each issue found, provide:

```
File:Line: path/to/file.py:42

Principle: Explicit is better than implicit

Issue: Function uses implicit default with `or` operator
Current code:
    def save_user(user, db=None):
        db = db or get_default_db()
        db.save(user)

Violation: Using `or` creates implicit behavior where falsy values
(including valid empty objects) trigger the default.

Suggested fix:
    def save_user(
        user: User,
        database: Database,
    ) -> None:
        """Save user to specified database."""
        if not user.is_valid():
            raise ValueError("Cannot save invalid user")

        database.save(user)

Impact: High - Can cause bugs with falsy but valid values
```

## 📈 Summary Format

After all issues, provide:

```
## Zen Compliance Summary

Total issues found: X

By Principle:
- Beautiful (PEP 8): X issues
- Explicit: X issues
- Simple: X issues
- Flat: X issues
- Readability: X issues
- Error Handling: X issues
- Python-Specific: X issues

By Severity:
- High: X issues (Fix immediately)
- Medium: X issues (Fix soon)
- Low: X issues (Nice to have)

Overall Zen Score: X/100

Top Priority Fixes:
1. [Highest impact issue]
2. [Second highest impact]
3. [Third highest impact]
```

## 🎯 Analysis Scope

Analyze:
- Current file if specific file is open
- All Python files in current directory if no file specified
- Specific file/function if user indicates selection

Prioritize:
1. **High severity** - Silent errors, missing type hints, deep nesting
2. **Medium severity** - PEP 8 violations, unclear names, magic numbers
3. **Low severity** - Minor style issues, docstring improvements

## ✅ What to Check For Specifically

### Red Flags (High Priority)
- Bare `except:` clauses
- Missing type hints
- Nesting > 3 levels
- Functions > 100 lines
- Magic numbers/strings
- Implicit defaults with `or`
- Single letter variable names (except `i`, `j`, `k` in loops)

### Code Smells (Medium Priority)
- Lines > 80 characters
- Missing docstrings
- Generic variable names (`data`, `info`, `temp`)
- Not using f-strings
- Old typing syntax (`List`, `Dict`)
- Using `os.path` instead of `pathlib`

### Style Issues (Low Priority)
- Missing trailing commas
- Import organization
- Extra blank lines
- Whitespace inconsistencies

---

**Provide specific, actionable feedback with code examples for fixes.**
