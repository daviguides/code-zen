# Python TDD Specification (LLM-Optimized)

## Core TDD Principles

### Batch Processing Over Sequential
- Generate multiple tests simultaneously
- Implement functions in logical groups
- Refactor entire modules for consistency

### Template-Driven Consistency
- Use repeatable patterns for test structure
- Maintain consistent naming and formatting
- Leverage pattern-following for reliability

### Property-Based Validation
- Focus on invariants that must always hold
- Use tests as anti-hallucination barriers
- Validate constraints and business rules

## Test Organization

### Test Suite Structure
```
tests/
├── test_core_logic.py          # Business logic tests
├── test_integrations.py        # Component interaction tests
├── test_edge_cases.py          # Boundary condition tests
└── test_error_handling.py      # Failure scenario tests
```

### Test Categories
1. **Unit tests** - Core logic validation
2. **Integration tests** - Component interaction
3. **Edge case tests** - Boundary conditions
4. **Error handling tests** - Failure scenarios
5. **Property tests** - Invariant validation
6. **Performance tests** - Critical path validation

## Test Naming Conventions

### Function Test Naming
```python
def test_{function_name}_{scenario}() -> None:
    """Test {function_name} with {scenario} scenario."""
```

### Integration Test Naming
```python
def test_{component_a}_integrates_with_{component_b}() -> None:
    """Test integration between {component_a} and {component_b}."""
```

### Error Test Naming
```python
def test_{function_name}_handles_{error_type}() -> None:
    """Test {function_name} properly handles {error_type}."""
```

## Scenario Matrix Requirements

### Matrix Definition
```python
TEST_SCENARIOS = {
    "function_name": {
        "valid_cases": [...]      # Happy path scenarios
        "edge_cases": [...]       # Boundary conditions
        "invalid_cases": [...]    # Error conditions
    }
}
```

### Coverage Requirements
- **100% of scenario matrix must be tested**
- **≥ 90% branch coverage** for business logic
- **All business constraints** must have property tests
- **All component interactions** must be tested

## Test Structure Pattern

### Base Test Pattern
```python
def test_function_name_scenario() -> None:
    """Test function_name with scenario description."""
    # Given: Setup test data
    # When: Execute function
    # Then: Validate results
    # Additional validations
```

### Arrange-Act-Assert (AAA)
1. **Arrange** (Given): Setup test data and mocks
2. **Act** (When): Execute function under test
3. **Assert** (Then): Validate results and side effects

## Type Safety in Tests

### Type Hints Required
```python
def test_calculate_discount(
    user: User,
    purchase_amount: Decimal,
    expected_discount: Decimal,
) -> None:
    """Test discount calculation with full type safety."""
    result = calculate_discount(user=user, amount=purchase_amount)
    assert result.discount_amount == expected_discount
```

## Docstring Requirements

### Test Docstrings
```python
def test_user_authentication_flow() -> None:
    """Test complete user authentication workflow.

    Validates that users can successfully register, login,
    access protected resources, and logout with proper
    session management throughout the process.

    This test covers:
    - User registration with email verification
    - Login with valid credentials
    - Session token validation
    - Protected resource access
    - Proper logout and session cleanup
    """
```

## Property-Based Testing

### Invariant Tests Required
- Output type consistency
- Domain constraints
- Business rule compliance
- Cross-function consistency

### Property Test Pattern
```python
def test_function_name_invariants(input_data):
    """Test invariants that must always hold."""
    result = function_name(input_data)

    # Property 1: Type consistency
    assert isinstance(result, ExpectedType)

    # Property 2: Domain constraints
    assert domain_constraint_check(result)

    # Property 3: Business rules
    assert business_rule_check(result)
```

## Anti-Hallucination Patterns

### Constraint Validation Tests
- **All business constraints** must have explicit tests
- Validate constraints are never violated
- Test edge cases where hallucination likely

### Cross-Function Consistency
- Test data flows correctly between functions
- Validate consistency across function chains
- Ensure related functions maintain invariants

### Type Safety Validation
- All public functions must have type hints
- Return types must be annotated
- Test validates type consistency

## Test Configuration

### pytest Configuration
```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = [
    "--strict-markers",
    "--cov=src",
    "--cov-branch",
    "--cov-report=term-missing",
    "--cov-fail-under=90",
    "--tb=short",
    "--maxfail=5",
    "-v",
]

markers = [
    "unit: Unit tests for individual functions",
    "integration: Integration tests for component interaction",
    "property: Property-based tests for invariants",
    "performance: Performance and load tests",
    "anti_hallucination: Tests to catch LLM errors"
]
```

## Dependency Implementation Order

### Test-First, Implement by Dependency
1. Generate all tests first
2. Implement in dependency order:
   - Data models and types
   - Core utility functions
   - Business logic functions
   - Integration layers
   - Error handling

## Parallel Test Generation

### Group Related Functionality
```python
TEST_GROUPS = {
    "authentication": ["login", "logout", "register", "validate_session"],
    "user_management": ["create_user", "update_user", "delete_user"],
    "data_processing": ["validate_input", "transform_data", "save_data"]
}
```

### Generate Groups Simultaneously
- Generate all tests for a functional group at once
- Implement all functions in group together
- Refactor entire group for consistency

## Quality Metrics

### Required Coverage
- Scenario coverage: 100%
- Branch coverage: ≥ 90%
- Property coverage: 100% of constraints
- Integration coverage: 100% of interactions

### Validation Checklist
- All functions tested
- All scenarios covered
- All constraints validated
- All integrations tested
- No hallucination risks
- Performance validated
- Type safety confirmed

## Integration with Code Standards

### Maintain Style Consistency
- Tests follow same style rules as production code
- Use Ruff for test formatting
- Apply 80-column limit
- Use type hints in tests

### Documentation Standards
- All test files have module docstrings
- Complex test setups documented
- Test data factories documented
- Mock patterns explained
