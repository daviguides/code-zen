---
description: Load Zen of Python context for this session
---

Apply Zen of Python principles throughout this session:

## 🎯 Fundamental Principles

- **Beautiful is better than ugly** - Follow PEP 8 conventions
- **Explicit is better than implicit** - Clear intentions always
- **Simple is better than complex** - Simplest solution first
- **Complex is better than complicated** - When complex, well-architected
- **Flat is better than nested** - Use guard clauses
- **Sparse is better than dense** - Proper spacing
- **Readability counts** - ALWAYS prioritize readability
- **Errors should never pass silently** - Explicit error handling
- **In the face of ambiguity, refuse the temptation to guess** - Be explicit

## ⚡ Pre-Code Checklist (MANDATORY)

Before generating ANY code, verify:

- [ ] **Beautiful**: Follows PEP 8?
- [ ] **Explicit**: Intentions clear?
- [ ] **Readable**: Developer understands without docs?
- [ ] **Simple**: Simplest approach possible?
- [ ] **Flat**: Avoids unnecessary nesting?

## 🎯 Decision Matrix

| Context | Primary Principles | Verification Question |
|---------|-------------------|----------------------|
| **Function** | Readability, Simple > Complex | "Can I explain in 1 sentence?" |
| **Class** | Explicit > Implicit, Single Responsibility | "Single responsibility?" |
| **Module** | Namespaces, One obvious way | "Imports clear?" |
| **Error** | Never silent, Unless silenced | "Failure is obvious?" |
| **Refactor** | Readability, Flat > Nested | "Improved clarity?" |

## 🚨 Red Flags - STOP if found

- **"This is too clever"** → Violates Simple > Complex
- **"Only works if you know X"** → Violates Explicit > Implicit
- **"5+ levels of if/for"** → Violates Flat > Nested
- **"Line 120+ chars"** → Violates Sparse > Dense
- **"Can't explain how it works"** → Violates Readability

## ✅ Conflict Resolution Hierarchy

When Zen principles conflict:

1. **Readability ALWAYS wins** - Never sacrifice legibility
2. **Explicit > Implicit** - When there's ambiguity
3. **Simple > Complex** - For simple problems
4. **Practicality > Purity** - With clear documented benefit
5. **Consistency > Cleverness** - In special cases

## 🛠️ Essential Templates

### Simple Function Template

```python
def function_name(
    param1: Type1,
    param2: Type2,
) -> ReturnType:
    """What this function does in one clear sentence."""
    # Validate inputs first (explicit > implicit)
    if not param1:
        raise ValueError("Clear error message")

    if param2 <= 0:
        raise ValueError("Another clear message")

    # Main logic (simple > complex)
    result = do_something(param1, param2)

    return result
```

### Class Template

```python
class ClassName:
    """Brief description of single responsibility."""

    def __init__(
        self,
        required_param: Type1,
        optional_param: Type2 | None = None,
    ) -> None:
        """Initialize ClassName with configuration."""
        # Validate inputs first
        if not required_param:
            raise ValueError("Clear validation message")

        self.required_param = required_param
        self.optional_param = optional_param or default_value

    def main_public_method(
        self,
        param: Type,
    ) -> ReturnType:
        """Main public interface method."""
        # Validate
        self._validate_inputs(param=param)

        # Orchestrate steps
        step1_result = self._step1(param)
        step2_result = self._step2(step1_result)

        return self._finalize(step2_result)

    def _validate_inputs(self, param: Type) -> None:
        """Validate inputs explicitly."""
        if not param:
            raise ValueError("Clear message")

    def _step1(self, param: Type) -> IntermediateType:
        """First step of process."""
        return result

    def _step2(self, input: IntermediateType) -> AnotherType:
        """Second step of process."""
        return result

    def _finalize(self, input: AnotherType) -> ReturnType:
        """Finalize and return result."""
        return final_result
```

### Guard Clauses (Flat > Nested)

```python
# ✅ FLAT - Use this pattern
def process_user(user: User | None) -> ProcessResult:
    """Process user with clear validation flow."""
    # Guard clauses - validate and exit early
    if not user:
        raise ValueError("User cannot be None")

    if not user.is_active:
        raise UserError("User account is not active")

    if not user.has_subscription:
        raise SubscriptionError("User has no subscription")

    if not user.subscription.is_valid():
        raise InvalidSubscriptionError("Subscription is not valid")

    # Main logic here - flat and clear
    return process(user)


# ❌ NESTED - Avoid this pattern
def process_user(user):
    if user:
        if user.is_active:
            if user.has_subscription:
                if user.subscription.is_valid():
                    return process(user)
```

### Error Handling Template

```python
def process_data(data: DataType) -> ResultType:
    """Process data with explicit error handling."""
    try:
        # Validate first
        if not data:
            raise ValueError("Data cannot be empty")

        # Attempt operation
        result = risky_operation(data)

        # Validate result
        if not result.is_valid():
            raise ProcessingError("Result validation failed")

        return result

    except NetworkError as e:
        # Handle specific known exceptions
        logger.error(f"Network error during processing: {e}")
        raise ProcessingError(
            "Service temporarily unavailable"
        ) from e

    except ValidationError as e:
        # Handle validation issues
        logger.warning(f"Validation failed: {e}")
        raise  # Re-raise as-is

    except Exception as e:
        # Never let unexpected errors pass silently
        logger.error(f"Unexpected error: {e}")
        raise ProcessingError(
            "An unexpected error occurred"
        ) from e
```

## 📏 Naming Conventions

### Functions

```python
# ✅ EXPLICIT
def calculate_user_discount(user: User, amount: Decimal) -> Decimal: ...
def validate_email_format(email: str) -> bool: ...
def convert_celsius_to_fahrenheit(celsius: float) -> float: ...

# ❌ IMPLICIT
def calc(u, a): ...
def validate(email): ...
def convert(temp): ...
```

### Classes

```python
# ✅ EXPLICIT
class EmailValidator: ...
class UserDiscountCalculator: ...
class PaymentProcessor: ...

# ❌ IMPLICIT
class Validator: ...
class Calculator: ...
class Processor: ...
```

### Variables

```python
# ✅ EXPLICIT
user_discount_percentage = 0.15
max_retry_attempts = 3
is_user_active: bool = True
has_valid_subscription: bool = False

# ❌ IMPLICIT
discount = 0.15
max_retries = 3
active = True
subscription = False
```

## 🚫 Anti-Patterns to Avoid

### Magic Numbers

```python
# ❌ ANTI-PATTERN
def calculate_price(base_price):
    if base_price > 1000:
        return base_price * 0.9
    return base_price

# ✅ CORRECT
BULK_DISCOUNT_THRESHOLD = 1000
BULK_DISCOUNT_RATE = Decimal("0.90")

def calculate_price(base_price: Decimal) -> Decimal:
    """Calculate final price with bulk discount if applicable."""
    if base_price > BULK_DISCOUNT_THRESHOLD:
        return base_price * BULK_DISCOUNT_RATE
    return base_price
```

### Implicit Behavior

```python
# ❌ ANTI-PATTERN
def save_user(user, db=None):
    db = db or get_default_db()
    db.save(user)

# ✅ CORRECT
def save_user(
    user: User,
    database: Database,
) -> None:
    """Save user to specified database."""
    if not user.is_valid():
        raise ValueError("Cannot save invalid user")

    database.save(user)

# Usage becomes explicit:
save_user(user=current_user, database=get_database())
```

### Silent Failures

```python
# ❌ ANTI-PATTERN
def parse_config(config_str):
    try:
        return json.loads(config_str)
    except:
        return {}

# ✅ CORRECT
def parse_config(config_str: str) -> dict[str, Any]:
    """Parse configuration string into dictionary."""
    if not config_str:
        raise ValueError("Configuration string cannot be empty")

    try:
        return json.loads(config_str)
    except json.JSONDecodeError as e:
        raise ConfigParsingError(
            f"Invalid JSON in configuration: {e}"
        ) from e
```

## 📊 Self-Verification Checklist

After writing code, verify ALL items:

### Fundamentals
- [ ] Code follows PEP 8 automatically
- [ ] All intentions are explicit
- [ ] Readability prioritized over cleverness

### Structure
- [ ] Solution is simple for the problem
- [ ] Structure is flat (no unnecessary nesting)
- [ ] Code is well-spaced and not dense

### Pragmatism
- [ ] Consistency maintained
- [ ] Ambiguities avoided
- [ ] One obvious way chosen

### Errors
- [ ] Errors never pass silently
- [ ] When suppressed, explicitly intentional

### Implementation
- [ ] Code delivered (don't let perfect be enemy of good)
- [ ] Quality maintained (but not rushed)
- [ ] Implementation is easy to explain

### Organization
- [ ] Namespaces used effectively

## 💡 Quick Self-Check Questions

### For Functions
- "Can I explain what this function does in one sentence?" → If NO: refactor
- "Does this function have hidden side effects?" → If YES: make explicit
- "Are validations clear and complete?" → If NO: add explicit validation

### For Classes
- "Does this class have a single clear responsibility?" → If NO: split
- "Is the public interface intuitive and explicit?" → If NO: rename methods
- "Is internal state managed clearly?" → If NO: add validation

### For Modules
- "Do all functions/classes belong to the same context?" → If NO: reorganize
- "Are imports organized and explicit?" → If NO: group properly
- "Is module less than 500 lines?" → If NO: consider splitting

---

**Apply these Zen principles to ALL code generated in this session.**

**Golden Rule:** If code passes ALL these checks → it's Pythonic ✅
