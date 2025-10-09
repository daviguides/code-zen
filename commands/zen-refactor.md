---
description: Refactor code following Zen of Python principles
---

Refactor the selected code or current file following Zen of Python principles.

## 🎯 Refactoring Goals

Transform code to be:
1. **More readable** - Clear and easy to understand
2. **More explicit** - Intentions obvious without guessing
3. **Simpler** - Remove unnecessary complexity
4. **Flatter** - Reduce nesting with guard clauses
5. **Better documented** - Clear docstrings and type hints
6. **Properly validated** - Explicit error handling

## 📋 Refactoring Checklist

Apply these transformations in order:

### 1. Add Type Hints

**Before:**
```python
def calculate_discount(user, amount, rate=0.1):
    return amount * (1 - rate)
```

**After:**
```python
from decimal import Decimal

def calculate_discount(
    user: User,
    amount: Decimal,
    rate: float = 0.1,
) -> Decimal:
    """Calculate discounted amount for user."""
    return amount * Decimal(str(1 - rate))
```

### 2. Add Docstrings

**Before:**
```python
def process_data(input_file, output_file, max_rows):
    # Function without docstring
    ...
```

**After:**
```python
def process_data(
    input_file: Path,
    output_file: Path,
    max_rows: int,
) -> ProcessingResult:
    """Process data from input file and write to output.

    Args:
        input_file: Path to input CSV file
        output_file: Path where processed data will be saved
        max_rows: Maximum number of rows to process

    Returns:
        ProcessingResult containing statistics and metadata

    Raises:
        FileNotFoundError: If input_file does not exist
        ValueError: If max_rows is negative or zero
    """
    ...
```

### 3. Improve Naming

**Before:**
```python
def calc(u, amt, t="std"):
    if t == "prem":
        return amt * 0.9
    return amt * 0.95
```

**After:**
```python
PREMIUM_DISCOUNT_RATE = Decimal("0.90")
STANDARD_DISCOUNT_RATE = Decimal("0.95")

def calculate_discounted_price(
    user: User,
    original_amount: Decimal,
    discount_type: str = "standard",
) -> Decimal:
    """Calculate final price after applying discount.

    Args:
        user: User object for validation
        original_amount: Original price before discount
        discount_type: Type of discount ("standard" or "premium")

    Returns:
        Final price after discount applied
    """
    if discount_type == "premium":
        return original_amount * PREMIUM_DISCOUNT_RATE
    return original_amount * STANDARD_DISCOUNT_RATE
```

### 4. Flatten Nested Structures

**Before:**
```python
def process_user(user):
    if user:
        if user.is_active:
            if user.has_subscription:
                if user.subscription.is_valid():
                    if user.subscription.plan == "premium":
                        return process_premium(user)
                    else:
                        return process_standard(user)
```

**After:**
```python
def process_user(user: User | None) -> ProcessResult:
    """Process user based on subscription status.

    Args:
        user: User object to process

    Returns:
        Processing result with user data

    Raises:
        ValueError: If user is None
        UserError: If user is not active
        SubscriptionError: If user has no valid subscription
    """
    # Guard clauses - validate and exit early
    if not user:
        raise ValueError("User cannot be None")

    if not user.is_active:
        raise UserError("User account is not active")

    if not user.has_subscription:
        raise SubscriptionError("User has no active subscription")

    if not user.subscription.is_valid():
        raise SubscriptionError("User subscription is not valid")

    # Main logic - flat and clear
    if user.subscription.plan == "premium":
        return process_premium(user)

    return process_standard(user)
```

### 5. Add Explicit Validation

**Before:**
```python
def divide_numbers(a, b):
    return a / b
```

**After:**
```python
def divide_numbers(
    numerator: float,
    denominator: float,
) -> float:
    """Divide numerator by denominator.

    Args:
        numerator: Number to be divided
        denominator: Number to divide by

    Returns:
        Result of division

    Raises:
        ValueError: If denominator is zero
    """
    if denominator == 0:
        raise ValueError("Cannot divide by zero")

    return numerator / denominator
```

### 6. Replace Magic Numbers

**Before:**
```python
def calculate_shipping(weight):
    if weight > 50:
        return weight * 0.15
    elif weight > 20:
        return weight * 0.10
    else:
        return weight * 0.05
```

**After:**
```python
# Shipping rate constants
HEAVY_WEIGHT_THRESHOLD = 50  # kg
MEDIUM_WEIGHT_THRESHOLD = 20  # kg
HEAVY_SHIPPING_RATE = Decimal("0.15")
MEDIUM_SHIPPING_RATE = Decimal("0.10")
LIGHT_SHIPPING_RATE = Decimal("0.05")

def calculate_shipping_cost(
    weight_kg: float,
) -> Decimal:
    """Calculate shipping cost based on package weight.

    Args:
        weight_kg: Package weight in kilograms

    Returns:
        Shipping cost in dollars

    Raises:
        ValueError: If weight is negative or zero
    """
    if weight_kg <= 0:
        raise ValueError("Weight must be positive")

    weight = Decimal(str(weight_kg))

    if weight > HEAVY_WEIGHT_THRESHOLD:
        return weight * HEAVY_SHIPPING_RATE

    if weight > MEDIUM_WEIGHT_THRESHOLD:
        return weight * MEDIUM_SHIPPING_RATE

    return weight * LIGHT_SHIPPING_RATE
```

### 7. Fix Error Handling

**Before:**
```python
def parse_json(text):
    try:
        return json.loads(text)
    except:
        return None
```

**After:**
```python
def parse_json(text: str) -> dict[str, Any]:
    """Parse JSON text into dictionary.

    Args:
        text: JSON string to parse

    Returns:
        Parsed dictionary

    Raises:
        ValueError: If text is empty
        JSONParseError: If text is not valid JSON
    """
    if not text:
        raise ValueError("JSON text cannot be empty")

    try:
        return json.loads(text)
    except json.JSONDecodeError as e:
        raise JSONParseError(
            f"Failed to parse JSON: {e}"
        ) from e
```

### 8. Make Behavior Explicit

**Before:**
```python
def save_user(user, db=None):
    db = db or get_default_db()
    db.save(user)
```

**After:**
```python
def save_user(
    user: User,
    database: Database,
) -> None:
    """Save user to specified database.

    Args:
        user: User object to save
        database: Database connection to use

    Raises:
        ValueError: If user is invalid
        DatabaseError: If save operation fails
    """
    if not user.is_valid():
        raise ValueError("Cannot save invalid user")

    try:
        database.save(user)
    except DatabaseError as e:
        logger.error(f"Failed to save user {user.id}: {e}")
        raise
```

### 9. Use Modern Python Syntax

**Before:**
```python
from typing import List, Dict, Optional

def process_items(items: Optional[List[str]]) -> Dict[str, int]:
    if items is None:
        items = []
    return {item: len(item) for item in items}
```

**After:**
```python
def process_items(
    items: list[str] | None = None,
) -> dict[str, int]:
    """Process list of items and return length mapping.

    Args:
        items: List of strings to process, defaults to empty list

    Returns:
        Dictionary mapping each item to its length
    """
    if items is None:
        items = []

    return {item: len(item) for item in items}
```

### 10. Extract Complex Logic

**Before:**
```python
def calculate_price(user, items, coupon):
    total = sum(item.price for item in items)
    if user.is_premium:
        total *= 0.9
    if len(items) > 10:
        total *= 0.95
    if coupon and coupon.is_valid():
        total -= coupon.amount
    if total < 0:
        total = 0
    return total
```

**After:**
```python
PREMIUM_DISCOUNT_RATE = Decimal("0.90")
BULK_DISCOUNT_RATE = Decimal("0.95")
BULK_DISCOUNT_THRESHOLD = 10

def calculate_price(
    user: User,
    items: list[Item],
    coupon: Coupon | None = None,
) -> Decimal:
    """Calculate final price with all discounts applied.

    Args:
        user: User making the purchase
        items: List of items being purchased
        coupon: Optional coupon for additional discount

    Returns:
        Final price after all discounts, minimum zero
    """
    base_total = _calculate_base_total(items)
    after_premium = _apply_premium_discount(base_total, user)
    after_bulk = _apply_bulk_discount(after_premium, items)
    final_price = _apply_coupon_discount(after_bulk, coupon)

    return max(final_price, Decimal("0"))


def _calculate_base_total(items: list[Item]) -> Decimal:
    """Calculate base total from item prices."""
    return sum(item.price for item in items)


def _apply_premium_discount(
    amount: Decimal,
    user: User,
) -> Decimal:
    """Apply premium user discount if applicable."""
    if user.is_premium:
        return amount * PREMIUM_DISCOUNT_RATE
    return amount


def _apply_bulk_discount(
    amount: Decimal,
    items: list[Item],
) -> Decimal:
    """Apply bulk purchase discount if applicable."""
    if len(items) > BULK_DISCOUNT_THRESHOLD:
        return amount * BULK_DISCOUNT_RATE
    return amount


def _apply_coupon_discount(
    amount: Decimal,
    coupon: Coupon | None,
) -> Decimal:
    """Apply coupon discount if coupon is valid."""
    if coupon and coupon.is_valid():
        return amount - coupon.amount
    return amount
```

## 📊 Refactoring Output Format

For each refactoring, show:

```
## Refactoring: [Brief description]

Principle: [Which Zen principle this addresses]

### Before
[Original code with issues highlighted]

### After
[Refactored code]

### Improvements
- ✅ [Specific improvement 1]
- ✅ [Specific improvement 2]
- ✅ [Specific improvement 3]

### Impact
Readability: ⬆️ High improvement
Maintainability: ⬆️ High improvement
Type Safety: ⬆️ Added complete type hints
Error Handling: ⬆️ Now explicit and informative
```

## 🎯 Refactoring Priority

Apply refactorings in this order of priority:

1. **High Priority** (Do first):
   - Add type hints
   - Fix error handling (remove silent failures)
   - Add input validation
   - Flatten deeply nested code

2. **Medium Priority** (Do next):
   - Improve naming (variables, functions, classes)
   - Add/improve docstrings
   - Extract complex functions
   - Replace magic numbers

3. **Low Priority** (Do last):
   - Update to modern Python syntax
   - Improve import organization
   - Add trailing commas
   - Minor style fixes

## ✅ Verification After Refactoring

After refactoring, verify:

- [ ] All type hints added
- [ ] All docstrings present and complete
- [ ] No nesting > 3 levels
- [ ] No magic numbers/strings
- [ ] Error handling is explicit
- [ ] Names are descriptive
- [ ] Each function has single responsibility
- [ ] Code is easier to read than before
- [ ] Original functionality preserved

## 🔄 Refactoring Process

1. **Analyze** - Identify main issues
2. **Plan** - Decide refactoring order
3. **Apply** - Make changes incrementally
4. **Verify** - Ensure improvements are clear
5. **Document** - Show before/after with explanations

---

**Show clear before/after code snippets for each refactoring applied.**
