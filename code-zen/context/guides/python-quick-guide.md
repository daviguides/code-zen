# Python Quick Reference Guide

## Setup & Tools
- **Python ≥ 3.13** (no `__future__` imports)
- **uv** for dependencies (not pip/poetry)
- **Ruff** for formatting + **80 columns** maximum

## Type System
- **Type hints always** (functions, classes, vars when needed)
- **Trailing commas** in signatures/calls
- **Python 3.13+ syntax** (`list[str]` not `List[str]`)

## Function Calls & Style
- **kwargs** for multiple arguments
- **Multiple lines** for +1 argument
- **f-strings always** (not `%` or `.format()`)

## Imports & Paths
- **pathlib** over `os.path`
- **3 groups** of imports: stdlib, third-party, local
- **Blank lines** between groups

## Quick Patterns

### Function Signature
```python
def function_name(
    param1: Type1,
    param2: Type2,
    param3: Type3 = default,
) -> ReturnType:
    """Docstring."""
    ...
```

### Function Call
```python
result = function_name(
    param1=value1,
    param2=value2,
    param3=value3,
)
```

### Guard Clauses
```python
def process(data: Data | None) -> Result:
    """Process with guard clauses."""
    if not data:
        raise ValueError("Data required")

    if not data.is_valid():
        raise ValidationError("Invalid data")

    # Main logic here
    return do_work(data)
```

### Error Handling
```python
try:
    result = risky_operation()
except SpecificError as e:
    logger.error(f"Specific error: {e}")
    raise ProcessingError("Message") from e
except Exception as e:
    logger.error(f"Unexpected: {e}")
    raise
```

## Package Structure
- **Avoid empty `__init__.py`** - not required since Python 3.3 (PEP 420)
- **Use only for aliases** and explicit exports

```python
# ✅ With useful aliases
from .module import Class, function

__all__ = ["Class", "function"]

# ❌ Empty file unnecessary
# __init__.py (empty)
```

## Documentation & Constants
- **Docstrings mandatory** (modules, classes, functions)
- **≤ 80 columns** with breaks when necessary
- **Avoid magic numbers** (use constants/config)

## Queries & Long Strings
- **SQL in multiple lines** with triple quotes
- **Break long strings** for readability

```python
query = """
    SELECT
        u.id,
        u.name
    FROM users u
    WHERE u.is_active = %(active)s
    ORDER BY u.created_at DESC
"""
```

## Library Preferences

### CLI & Terminal
- **typer** (CLI with type hints)
- **rich** (beautiful output)

### Web & APIs
- **fastapi** (async APIs with type hints)

### Data Validation
- **pydantic** (validation, serialization)

### Testing
- **pytest** (testing framework)
- **Classes for test suites** (organization)

### Data Processing
- **polars** (DataFrames - performance/lazy eval)

### LLM & AI
- **litellm** (unified LLM APIs)

### Database
- **motor** (MongoDB async)

## Integration Philosophy
- **Async-first** when makes sense
- **Performance-focused** libraries
- **Type hints support** mandatory

## Common Mistakes to Avoid

### ❌ Don't
```python
# Magic numbers
if price > 1000: discount = 0.9

# Deep nesting
if x:
    if y:
        if z:
            do_something()

# Implicit defaults
def save(user, db=None):
    db = db or get_default()

# Silent failures
try:
    risky()
except:
    pass

# Bare types
from typing import List
items: List[str] = []
```

### ✅ Do
```python
# Named constants
BULK_THRESHOLD = 1000
BULK_DISCOUNT = 0.9
if price > BULK_THRESHOLD:
    discount = BULK_DISCOUNT

# Guard clauses
if not x:
    raise ValueError("x required")
if not y:
    raise ValueError("y required")
if not z:
    raise ValueError("z required")
do_something()

# Explicit parameters
def save(user: User, database: Database) -> None:
    database.save(user)

# Explicit errors
try:
    risky()
except SpecificError as e:
    logger.error(f"Error: {e}")
    raise ProcessingError("Failed") from e

# Modern types
items: list[str] = []
```

## Decision Matrix

| Context | Primary Principles | Quick Check |
|---------|-------------------|-------------|
| **Function** | Readability, Simple > Complex | "Explain in 1 sentence?" |
| **Class** | Explicit > Implicit, SRP | "Single responsibility?" |
| **Module** | Namespaces, One obvious way | "Imports clear?" |
| **Error** | Never silent, Unless silenced | "Failure obvious?" |
| **Refactor** | Readability, Flat > Nested | "Improved clarity?" |

## Conflict Resolution

When principles conflict:

1. **Readability ALWAYS wins**
2. **Explicit > Implicit**
3. **Simple > Complex**
4. **Practicality > Purity** (with clear benefit)
5. **Consistency > Cleverness**
