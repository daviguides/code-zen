# Universal Naming Conventions Specification

## Core Principles

### Explicit Over Implicit
- Names must clearly express **intent and purpose**
- Avoid abbreviations unless universally understood
- **No cryptic or ambiguous names**

### Self-Documenting Code
- Names should **eliminate need for comments**
- Reader should understand purpose without documentation
- **Code tells a clear story**

## Magic Values Prohibition

### Never Use Magic Numbers/Strings
- **No literal values** directly in code
- Use **named constants** or **configuration files**
- **Make intentions explicit** through descriptive names

**Conceptual example:**
```
// ❌ MAGIC VALUE
if (attempts > 3) { ... }

// ✅ NAMED CONSTANT
const MAX_RETRY_ATTEMPTS = 3;
if (attempts > MAX_RETRY_ATTEMPTS) { ... }
```

## Function Naming

### Verb-Based Names
- Functions **perform actions** - use verbs
- Be **specific** about what action is performed
- Avoid generic verbs when specific ones exist

**Conceptual patterns:**
- `calculate_user_discount` (NOT `calc` or `discount`)
- `validate_email_format` (NOT `validate` or `check`)
- `convert_celsius_to_fahrenheit` (NOT `convert` or `transform`)

### Return Type Indicators
- Boolean functions: `is_`, `has_`, `can_`, `should_`
- Getter functions: `get_`, `fetch_`, `retrieve_`
- Setter functions: `set_`, `update_`, `modify_`

## Class Naming

### Noun-Based Names
- Classes represent **things** - use nouns
- Be **specific** about what is represented
- Avoid generic suffixes unless truly generic

**Conceptual patterns:**
- `EmailValidator` (NOT `Validator`)
- `UserDiscountCalculator` (NOT `Calculator`)
- `PaymentProcessor` (NOT `Processor`)

### Single Responsibility Naming
- Class name should reflect **one clear responsibility**
- If name requires "And" or "Or", class is doing too much
- Consider splitting into multiple classes

## Variable Naming

### Descriptive and Contextual
- Variables should indicate **what they store**
- Include context when not obvious from scope
- Avoid single-letter names (except in narrow scopes)

**Conceptual patterns:**
- `user_discount_percentage = 0.15` (NOT `discount`)
- `max_retry_attempts = 3` (NOT `max_retries`)
- `is_user_active: bool = True` (NOT `active`)
- `has_valid_subscription: bool = False` (NOT `subscription`)

### Boolean Naming
- Use question form: `is_`, `has_`, `can_`, `should_`
- Name should make condition clear
- Avoid negatives when possible

## Constant Naming

### UPPER_SNAKE_CASE (Language-Dependent)
- Constants use distinctive naming
- Indicates immutability and global scope
- Group related constants with prefixes

**Conceptual patterns:**
- `MAX_RETRY_ATTEMPTS = 3`
- `API_TIMEOUT_SECONDS = 30`
- `DEFAULT_PAGE_SIZE = 50`

## Configuration Values

### Externalize Configuration
- **Don't hardcode** environment-specific values
- Use **environment variables** or **config files**
- **Document** all required configurations

### Explicit Configuration Names
- Configuration keys should be self-explanatory
- Include units when applicable
- Use consistent naming scheme

## Language-Agnostic Principles

These conventions apply **regardless of programming language**:

1. **Clarity trumps brevity**
2. **Consistency within codebase**
3. **Follow language conventions** (snake_case vs camelCase)
4. **No abbreviations** except standard industry terms (HTTP, API, URL, etc.)
5. **Context-specific naming** based on domain
