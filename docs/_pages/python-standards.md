---
layout: page
title: Python Standards
---

## Python-Specific Implementation Guide

Code Zen's Python standards combine modern best practices with the timeless wisdom of the Zen of Python.

---

## **Setup & Tools**

### **Python Version**
- **Python ≥ 3.13** (no `__future__` imports needed)
- Use modern syntax and features

### **Package Management**
- **uv** for dependencies (not pip/poetry)
- Faster, more reliable dependency resolution

### **Code Formatting**
- **Ruff** for formatting and linting
- **80 columns maximum** line length
- Automatic formatting on save

---

## **Type System**

### **Type Hints Always**
- **Mandatory** for all functions, classes, and variables when necessary
- Use **Python 3.13+ syntax**: `list[str]` instead of `List[str]`

```python
# ✅ GOOD
def calculate_discount(
    user: User,
    amount: Decimal,
) -> Decimal:
    ...

# ❌ BAD
def calculate_discount(user, amount):
    ...
```

### **Trailing Commas**
- Use trailing commas in signatures and calls
- Improves diff readability

```python
# ✅ GOOD
def process_data(
    input_file: Path,
    output_dir: Path,
    options: dict[str, Any],
) -> None:
    ...

# ❌ BAD
def process_data(input_file: Path, output_dir: Path, options: dict[str, Any]) -> None:
    ...
```

---

## **Function Calls & Style**

### **Keyword Arguments**
- Use **kwargs** for multiple arguments
- Improves readability and maintainability

```python
# ✅ GOOD
result = calculate_discount(
    user=current_user,
    amount=purchase_total,
)

# ❌ BAD
result = calculate_discount(current_user, purchase_total)
```

### **Multiple Lines**
- Use **multiple lines** for more than 1 argument
- Each argument on its own line

### **String Formatting**
- **f-strings always** (not `%` or `.format()`)
- Modern, readable, performant

```python
# ✅ GOOD
message = f"User {user.name} purchased {amount}"

# ❌ BAD
message = "User %s purchased %s" % (user.name, amount)
message = "User {} purchased {}".format(user.name, amount)
```

---

## **Imports & Organization**

### **Path Handling**
- **pathlib** instead of `os.path`
- Object-oriented, cross-platform

```python
# ✅ GOOD
from pathlib import Path

config_file = Path("config") / "settings.yaml"

# ❌ BAD
import os
config_file = os.path.join("config", "settings.yaml")
```

### **Import Groups**
- **3 groups**: stdlib, third-party, local
- **Blank lines** between groups

```python
# Standard library
from pathlib import Path
from typing import Any

# Third-party
from fastapi import FastAPI
from pydantic import BaseModel

# Local
from .models import User
from .utils import calculate_discount
```

---

## **Package Structure**

### **Avoid Empty `__init__.py`**
- Not required since Python 3.3 (PEP 420)
- Use only for **aliases** and **explicit exports**

```python
# ✅ GOOD - With useful aliases
from .module import Class, function

__all__ = [
    "Class",
    "function",
]

# ❌ BAD - Empty file
# __init__.py (empty file)
```

---

## **Documentation & Constants**

### **Docstrings Required**
- **Mandatory** for modules, classes, functions
- Follow Google Style extended with semantic layer
- **≤ 80 columns** with breaks when necessary

```python
def calculate_discount(
    user: User,
    amount: Decimal,
) -> Decimal:
    """Calculate discount based on user loyalty and purchase volume.

    Responsibility:
        Single source of truth for business discount logic.

    Context:
        Called during checkout before payment processing.

    Args:
        user: User account for loyalty tier determination
        amount: Purchase amount for volume-based calculation

    Returns:
        Final discount amount, capped at maximum allowed
    """
```

### **Avoid Magic Numbers**
- Use **named constants** or **config files**
- Make intentions explicit

```python
# ✅ GOOD
MAX_DISCOUNT_RATE = 0.25
BULK_THRESHOLD = 1000

if amount > BULK_THRESHOLD:
    discount = amount * MAX_DISCOUNT_RATE

# ❌ BAD
if amount > 1000:
    discount = amount * 0.25
```

---

## **Library Preferences**

### **CLI & Terminal**
- **typer** - CLI with type hints (vs click/argparse)
- **rich** - Beautiful terminal output (vs plain print)

### **Web & APIs**
- **fastapi** - Async APIs with type hints (vs flask/django)

### **Data Validation & Modeling**
- **pydantic** - Validation, serialization, models

### **Testing**
- **pytest** - Testing framework
- **Classes to group test suites** - organization

### **Data Processing**
- **polars** - DataFrames (vs pandas - performance/lazy eval)

### **LLM & AI**
- **litellm** - Unified LLM APIs (vs openai direct)

### **Database**
- **motor** - MongoDB async (vs pymongo sync)

---

## **Integration Philosophy**

### **Core Principles**
- **Async-first** when it makes sense
- **Type hints support** mandatory
- **Performance-focused** when available

### **Modern Python**
All standards are designed for **Python 3.13+**:
- Pattern matching
- Type parameter syntax
- Improved error messages
- Performance improvements

---

## **Quick Reference Template**

```python
"""Module docstring explaining purpose.

Architecture:
    Role in system architecture

Responsibility:
    Main responsibility
"""

from pathlib import Path
from typing import Any

from fastapi import FastAPI
from pydantic import BaseModel

from .models import User


MAX_RETRY_ATTEMPTS = 3


def process_user_data(
    user: User,
    input_file: Path,
) -> dict[str, Any]:
    """Process user data from file.

    Responsibility:
        Single source for user data processing logic.

    Context:
        Called during data import workflow.

    Args:
        user: User performing the import
        input_file: Path to data file

    Returns:
        Dictionary with processed data

    Raises:
        ValueError: If input_file doesn't exist
    """
    if not input_file.exists():
        raise ValueError(f"File not found: {input_file}")

    # Process data
    result = _parse_file(input_file=input_file)

    return result


def _parse_file(input_file: Path) -> dict[str, Any]:
    """Parse input file (private helper)."""
    # Implementation
    ...
```

---

## **Key Takeaways**

- **Type hints everywhere** - No exceptions
- **Modern syntax** - Python 3.13+ features
- **Explicit over implicit** - kwargs, pathlib, f-strings
- **Async-first** - When it makes sense
- **Performance-focused** - polars, motor, litellm
- **Documentation required** - Semantic docstrings

These standards ensure Python code is readable, maintainable, and optimized for both human developers and AI assistants.
