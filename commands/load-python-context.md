---
description: Load Python-specific coding standards for this session
---

Apply Python-specific coding standards throughout this session:

## 🐍 Python Setup & Tools

- **Python ≥ 3.13** - Use modern syntax (no `__future__` imports)
- **uv** for dependency management (not pip/poetry)
- **Ruff** for formatting and linting
- **Line length: 80 columns maximum**

## 🔤 Type System Requirements

### Type Hints Always Required

```python
# ✅ CORRECT - Type hints on everything
def calculate_discount(
    user: User,
    amount: Decimal,
    discount_rate: float = 0.1,
) -> Decimal:
    """Calculate discounted amount."""
    return amount * Decimal(str(1 - discount_rate))


# ❌ WRONG - No type hints
def calculate_discount(user, amount, discount_rate=0.1):
    return amount * (1 - discount_rate)
```

### Modern Python 3.13+ Syntax

```python
# ✅ CORRECT - Python 3.13+ syntax
def process_items(items: list[str]) -> dict[str, int]:
    """Process list of items."""
    return {item: len(item) for item in items}


# ❌ WRONG - Old syntax with typing imports
from typing import List, Dict

def process_items(items: List[str]) -> Dict[str, int]:
    return {item: len(item) for item in items}
```

### Trailing Commas

```python
# ✅ CORRECT - Trailing commas in signatures
def create_user(
    name: str,
    email: str,
    age: int,
) -> User:
    """Create new user instance."""
    return User(
        name=name,
        email=email,
        age=age,
    )


# ❌ WRONG - No trailing commas
def create_user(
    name: str,
    email: str,
    age: int
) -> User:
    return User(name=name, email=email, age=age)
```

## 🎯 Function Calls & Style

### Use kwargs for Multiple Arguments

```python
# ✅ CORRECT - kwargs for clarity
result = process_data(
    input_file="data.csv",
    output_file="result.json",
    encoding="utf-8",
    max_rows=1000,
)

# ❌ WRONG - Positional arguments
result = process_data("data.csv", "result.json", "utf-8", 1000)
```

### Multiple Lines for Multiple Arguments

```python
# ✅ CORRECT - One argument per line when > 1 arg
user = create_user(
    name="John Doe",
    email="john@example.com",
)

# ✅ ALSO CORRECT - Single line when 1 arg
result = calculate(value=42)

# ❌ WRONG - Multiple args on one line
user = create_user(name="John Doe", email="john@example.com")
```

### f-strings Always

```python
# ✅ CORRECT - f-strings
message = f"User {user.name} has {user.points} points"
error = f"Invalid value: {value!r}"

# ❌ WRONG - Old string formatting
message = "User %s has %d points" % (user.name, user.points)
message = "User {} has {} points".format(user.name, user.points)
```

## 📦 Imports & Organization

### Import Groups with Blank Lines

```python
# ✅ CORRECT - 3 groups with blank lines
import json
import os
from pathlib import Path

import requests
from pydantic import BaseModel

from myapp.models import User
from myapp.utils import validate_email


# ❌ WRONG - No organization
import json
from myapp.models import User
import requests
from pathlib import Path
import os
```

### pathlib vs os.path

```python
# ✅ CORRECT - Use pathlib
from pathlib import Path

config_file = Path("config") / "settings.json"
if config_file.exists():
    data = config_file.read_text()

# ❌ WRONG - Use os.path
import os

config_file = os.path.join("config", "settings.json")
if os.path.exists(config_file):
    with open(config_file) as f:
        data = f.read()
```

## 🏗️ Package Structure

### Avoid Empty __init__.py Files

```python
# ✅ CORRECT - __init__.py with exports
from .module import Class, function

__all__ = [
    "Class",
    "function",
]

# ✅ ALSO CORRECT - No __init__.py at all (PEP 420)
# Since Python 3.3, namespace packages don't need __init__.py

# ❌ WRONG - Empty __init__.py with no purpose
# __init__.py
# (empty file)
```

## 📚 Documentation Requirements

### Docstrings Mandatory

```python
# ✅ CORRECT - Complete docstring
def calculate_user_discount(
    user: User,
    purchase_amount: Decimal,
    loyalty_years: int,
) -> Decimal:
    """Calculate discount based on user loyalty and purchase amount.

    Args:
        user: User object containing account information
        purchase_amount: Total purchase amount before discount
        loyalty_years: Number of years user has been a customer

    Returns:
        Final discount amount as Decimal

    Raises:
        ValueError: If purchase_amount is negative or zero
        ValueError: If loyalty_years is negative
    """
    # Implementation
    ...


# ❌ WRONG - No docstring
def calculate_user_discount(
    user: User,
    purchase_amount: Decimal,
    loyalty_years: int,
) -> Decimal:
    # Implementation without docstring
    ...
```

### Line Length ≤ 80 Columns

```python
# ✅ CORRECT - Break long docstrings
def process_large_dataset(
    input_path: Path,
    output_path: Path,
) -> ProcessingResult:
    """Process large dataset with multiple transformations.

    This function reads data from input_path, applies a series of
    transformations including validation, normalization, and
    aggregation, then writes results to output_path.

    Args:
        input_path: Path to input CSV file
        output_path: Path where processed data will be saved

    Returns:
        ProcessingResult containing statistics and metadata
    """
    ...
```

## 🔢 Constants & Magic Numbers

### Use Named Constants

```python
# ✅ CORRECT - Named constants
MAX_RETRY_ATTEMPTS = 3
DEFAULT_TIMEOUT_SECONDS = 30
EMAIL_REGEX_PATTERN = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

def fetch_data(url: str) -> dict[str, Any]:
    """Fetch data with retries."""
    for attempt in range(MAX_RETRY_ATTEMPTS):
        try:
            response = requests.get(url, timeout=DEFAULT_TIMEOUT_SECONDS)
            return response.json()
        except RequestError:
            if attempt == MAX_RETRY_ATTEMPTS - 1:
                raise


# ❌ WRONG - Magic numbers
def fetch_data(url: str) -> dict[str, Any]:
    for attempt in range(3):
        try:
            response = requests.get(url, timeout=30)
            return response.json()
        except RequestError:
            if attempt == 2:
                raise
```

## 📝 Long Strings & Queries

### SQL in Multiple Lines

```python
# ✅ CORRECT - SQL with proper formatting
query = """
    SELECT
        user_id,
        user_name,
        email,
        created_at
    FROM users
    WHERE
        is_active = TRUE
        AND created_at > :start_date
    ORDER BY created_at DESC
    LIMIT :max_results
"""

# ❌ WRONG - Long single line
query = "SELECT user_id, user_name, email, created_at FROM users WHERE is_active = TRUE AND created_at > :start_date ORDER BY created_at DESC LIMIT :max_results"
```

### Break Long Strings

```python
# ✅ CORRECT - Break long error messages
error_message = (
    f"Failed to process user {user.id}: "
    f"Invalid email format '{user.email}'. "
    f"Expected format: username@domain.com"
)

# ✅ ALSO CORRECT - Triple quotes for very long messages
help_text = """
Usage: process_data [OPTIONS] INPUT OUTPUT

Process data from INPUT file and write results to OUTPUT file.

Options:
    --format FMT    Output format (json, csv, xml)
    --verbose       Enable verbose logging
    --help          Show this message and exit
"""
```

## 🎨 Library Preferences

### CLI & Terminal
```python
# ✅ Use typer for CLI (not click/argparse)
import typer
from rich.console import Console

app = typer.Typer()
console = Console()

@app.command()
def main(
    input_file: Path,
    verbose: bool = False,
) -> None:
    """Process input file."""
    if verbose:
        console.print("[green]Processing...[/green]")
```

### Data Validation
```python
# ✅ Use pydantic for validation
from pydantic import BaseModel, EmailStr, Field

class User(BaseModel):
    """User model with validation."""
    name: str = Field(min_length=1, max_length=100)
    email: EmailStr
    age: int = Field(ge=0, le=150)
```

### Testing
```python
# ✅ Use pytest with classes for organization
import pytest

class TestUserAuthentication:
    """Test suite for user authentication."""

    def test_login_with_valid_credentials(self) -> None:
        """Test successful login with valid credentials."""
        user = authenticate(email="test@example.com", password="secret")
        assert user.is_authenticated

    def test_login_with_invalid_credentials(self) -> None:
        """Test login failure with invalid credentials."""
        with pytest.raises(AuthenticationError):
            authenticate(email="test@example.com", password="wrong")
```

### Data Processing
```python
# ✅ Use polars (not pandas)
import polars as pl

df = pl.read_csv("data.csv")
result = (
    df
    .filter(pl.col("age") > 18)
    .group_by("country")
    .agg(pl.col("income").mean())
)
```

## ⚡ Async-First When Appropriate

```python
# ✅ CORRECT - Async for I/O operations
import asyncio
from motor.motor_asyncio import AsyncIOMotorClient

async def fetch_user(user_id: str) -> User:
    """Fetch user from database asynchronously."""
    client = AsyncIOMotorClient()
    db = client.myapp
    user_data = await db.users.find_one({"_id": user_id})
    return User(**user_data)


async def main() -> None:
    """Main async entry point."""
    users = await asyncio.gather(
        fetch_user("user1"),
        fetch_user("user2"),
        fetch_user("user3"),
    )
```

## 📊 Configuration Integration

### pyproject.toml Example

```toml
[project]
name = "myproject"
version = "0.1.0"
requires-python = ">=3.13"

[tool.ruff]
line-length = 80
target-version = "py313"

[tool.ruff.lint]
select = ["E", "F", "W", "I", "N"]
ignore = []

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_classes = "Test*"
python_functions = "test_*"

[tool.mypy]
python_version = "3.13"
strict = true
warn_return_any = true
warn_unused_configs = true
```

## ✅ Session Standards Checklist

For ALL Python code in this session:

- [ ] Python ≥ 3.13 syntax (list[str], dict[str, int])
- [ ] Type hints on all functions, classes, and variables when needed
- [ ] Trailing commas in multi-line signatures and calls
- [ ] kwargs for function calls with multiple arguments
- [ ] f-strings for all string formatting
- [ ] pathlib for file operations
- [ ] Imports organized in 3 groups with blank lines
- [ ] Docstrings on all public functions, classes, modules
- [ ] Line length ≤ 80 columns
- [ ] Named constants instead of magic numbers
- [ ] Preferred libraries (typer, pydantic, pytest, polars, etc.)
- [ ] Async-first for I/O operations when appropriate

---

**Apply these Python standards to ALL code generated in this session.**
