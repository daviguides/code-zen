# Zen of Python Implementation Guide

## Decision Matrix - Context-Based Prioritization

| Implementation Context | Primary Principles | Secondary Principles | Mandatory Check |
|------------------------|-------------------|----------------------|-----------------|
| **Writing Function** | Readability counts<br>Simple > Complex | Explicit > Implicit<br>Flat > Nested | "Can explain in one sentence?" |
| **Structuring Class** | Explicit > Implicit<br>Namespaces | Simple > Complex<br>Beautiful > Ugly | "Single responsibility?" |
| **Organizing Module** | Namespaces<br>One obvious way | Flat > Nested<br>Sparse > Dense | "Imports clear?" |
| **Error Handling** | Errors never silent<br>Unless silenced | Explicit > Implicit<br>Refuse to guess | "Failure obvious?" |
| **Refactoring** | Readability counts<br>Simple > Complex | Beautiful > Ugly<br>Flat > Nested | "Improved clarity?" |

## Implementation Workflow

### Phase 1: Pre-Code (MANDATORY)

**BEFORE generating any code:**

1. **Check Pre-Implementation Checklist**
   - Focus on Beautiful, Explicit, Readability
   - Review primary principles for context

2. **Identify Implementation Context**
   - Function, class, module, error handling, or refactoring?
   - Which principles are most important?

3. **Choose Appropriate Templates**
   - Use established patterns
   - Don't reinvent the wheel

### Phase 2: During Code

**WHILE writing code:**

1. **Apply Explicit Naming Conventions**
   - Functions: verb-based, descriptive
   - Classes: noun-based, single responsibility
   - Variables: contextual, clear

2. **Use Flat Structures**
   - Guard clauses over nested ifs
   - Early returns
   - Maximum 3 levels of indentation

3. **Make All Intentions Clear**
   - No implicit behavior
   - Explicit validation
   - Clear error messages

4. **Handle Errors Explicitly**
   - Specific exception types
   - Never bare `except:`
   - Exception chaining

### Phase 3: Post-Code (MANDATORY)

**AFTER writing code:**

1. **Run Complete Self-Verification**
   - Check all Zen principles
   - Use review checklist
   - Look for red flags

2. **Execute Auto-Approval Checklist**
   - All fundamentals must pass
   - Structure must be sound
   - Errors must be handled

3. **Fix Issues and Re-check**
   - If any verification fails, fix immediately
   - Re-run checks until all pass
   - Only finalize when ALL checks pass

## Context-Specific Guidance

### Writing Functions

**Apply:**
- Single responsibility
- Clear, descriptive name
- Type hints on all parameters
- Docstring with Args/Returns/Raises
- Validation at function start
- Guard clauses for flat structure
- No hidden side effects

**Example:**
```python
def calculate_user_discount(
    user: User,
    purchase_amount: Decimal,
) -> Decimal:
    """Calculate discount for user purchase."""
    # Validate first
    if not user.is_active:
        raise ValueError("User not active")
    if purchase_amount <= 0:
        raise ValueError("Amount must be positive")

    # Main logic
    base_discount = _get_loyalty_discount(user)
    volume_discount = _get_volume_discount(purchase_amount)

    return min(base_discount + volume_discount, Decimal("0.25"))
```

### Structuring Classes

**Apply:**
- Single clear responsibility
- Explicit public interface
- Private methods as helpers
- Constructor validates state
- Type hints on all methods
- Docstrings on class and public methods

**Example:**
```python
class DiscountCalculator:
    """Calculate discounts based on user and purchase criteria."""

    def __init__(self, max_discount: Decimal = Decimal("0.25")) -> None:
        self.max_discount = max_discount

    def calculate(self, user: User, amount: Decimal) -> Decimal:
        """Calculate final discount."""
        self._validate_inputs(user=user, amount=amount)

        loyalty = self._calculate_loyalty(user)
        volume = self._calculate_volume(amount)

        return min(loyalty + volume, self.max_discount)

    def _validate_inputs(self, user: User, amount: Decimal) -> None:
        """Validate calculation inputs."""
        if not user.is_active:
            raise ValueError("User not active")
        if amount <= 0:
            raise ValueError("Amount must be positive")
```

### Organizing Modules

**Apply:**
- One clear responsibility per module
- Module docstring explains purpose
- Imports in 3 groups (stdlib, third-party, local)
- Main function at top
- Helpers ordered by usage
- Module < 500 lines

**Example:**
```python
"""User discount calculation module.

Provides functionality to calculate discounts based on
loyalty and purchase volume.
"""

from decimal import Decimal

from pydantic import BaseModel

from core.models import User


def calculate_discount(user: User, amount: Decimal) -> Decimal:
    """Main function to calculate discount."""
    _validate_inputs(user, amount)
    return _apply_discount_rules(user, amount)


def _validate_inputs(user: User, amount: Decimal) -> None:
    """Helper to validate inputs."""
    ...


def _apply_discount_rules(user: User, amount: Decimal) -> Decimal:
    """Helper to apply discount rules."""
    ...
```

### Error Handling

**Apply:**
- Validate inputs explicitly
- Use specific exception types
- No bare `except:`
- Include context in messages
- Exception chaining with `from e`
- Log errors appropriately

**Example:**
```python
def process_payment(data: PaymentData) -> PaymentResult:
    """Process payment with explicit error handling."""
    try:
        if not data.amount > 0:
            raise ValueError("Amount must be positive")

        result = charge_card(data)

        if not result.success:
            raise PaymentError(f"Charge failed: {result.error}")

        return result

    except NetworkError as e:
        logger.error(f"Network error: {e}")
        raise PaymentError("Service unavailable") from e

    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        raise PaymentError("Processing failed") from e
```

### Refactoring

**Process:**

1. **Identify Problems**
   - Deep nesting?
   - Unclear names?
   - Magic numbers?
   - Implicit behavior?

2. **Apply Zen Fixes**
   - Flatten with guard clauses
   - Rename for clarity
   - Extract constants
   - Make explicit

3. **Verify Improvements**
   - Is code clearer?
   - Complexity reduced?
   - Functionality maintained?

**Before:**
```python
def calc(u, amt):
    if u["type"] == "premium":
        if amt > 100:
            return amt * 0.9
        else:
            return amt * 0.95
    else:
        return amt
```

**After:**
```python
PREMIUM_DISCOUNT = Decimal("0.10")
PREMIUM_SMALL_DISCOUNT = Decimal("0.05")

def calculate_discounted_price(
    user: User,
    amount: Decimal,
) -> Decimal:
    """Calculate price with user-specific discount."""
    if amount <= 0:
        raise ValueError("Amount must be positive")

    if user.subscription_type == "premium":
        return _apply_premium_discount(amount)

    return amount


def _apply_premium_discount(amount: Decimal) -> Decimal:
    """Apply discount for premium users."""
    if amount > 100:
        return amount * (1 - PREMIUM_DISCOUNT)
    return amount * (1 - PREMIUM_SMALL_DISCOUNT)
```

## Conflict Resolution

### When Principles Conflict

Use this hierarchy:

1. **Readability ALWAYS wins** - Never sacrifice legibility
2. **Explicit > Implicit** - When there's ambiguity
3. **Simple > Complex** - For simple problems
4. **Practicality > Purity** - With clear documented benefit
5. **Consistency > Cleverness** - In special cases

### Example Conflicts

**Purity vs Practicality:**
```python
# Pure (always explicit):
config = load_config(path=Path("config.yaml"))

# Practical (when path is always same):
DEFAULT_CONFIG_PATH = Path("config.yaml")

def load_default_config() -> Config:
    """Load config from default location."""
    return load_config(path=DEFAULT_CONFIG_PATH)

# Practicality wins when:
# - Pattern is used 20+ times
# - Default is well-documented
# - Clear practical benefit
```

## Integration with Development Workflow

### New Feature Development
1. Review specs and requirements
2. Check pre-code checklist
3. Choose templates based on context
4. Implement with Zen principles
5. Run post-code verification
6. Fix issues until all checks pass

### Bug Fixing
1. Identify root cause
2. Determine which principle was violated
3. Apply appropriate Zen fix
4. Add validation to prevent recurrence
5. Add regression test

### Code Review
1. Use review checklist
2. Check for anti-patterns
3. Verify Zen compliance
4. Provide specific, actionable feedback
5. Ensure all checks pass before approval

## Success Metrics

**Code Quality:**
- Can explain each function in one sentence?
- No nesting > 3 levels?
- All errors handled explicitly?
- Magic numbers eliminated?

**Readability:**
- Junior dev can understand?
- Code tells clear story?
- No cleverness for cleverness sake?

**Maintainability:**
- Easy to add features?
- Clear where changes go?
- Consistent patterns used?
