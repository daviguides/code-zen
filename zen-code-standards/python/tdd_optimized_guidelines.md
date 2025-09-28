# TDD Optimized Guidelines for LLMs

## 🧠 LLM-Native TDD Philosophy

This approach leverages LLM strengths: parallel thinking, template consistency, comprehensive scenario generation, and property-based validation while mitigating weaknesses like hallucinations and sequential limitations.

## ⚡ Core Optimization Principles

### **Batch Processing Over Sequential**
- Generate multiple tests simultaneously
- Implement functions in logical groups
- Refactor entire modules for consistency

### **Template-Driven Consistency**
- Use repeatable patterns for test structure
- Maintain consistent naming and formatting
- Leverage LLM's pattern-following strength

### **Property-Based Validation**
- Focus on invariants that must always hold
- Use tests as anti-hallucination barriers
- Validate constraints and business rules

## 🚀 LLM-Optimized TDD Workflows

### **Workflow 1: Test Suite First**

**Step 1: Comprehensive Test Design**
```markdown
Prompt: "Design complete test suite for [feature] with these components:
- Unit tests for core logic
- Integration tests for component interaction
- Edge case tests for boundary conditions
- Error handling tests for failure scenarios"
```

**Step 2: Batch Implementation**
```python
# LLM generates all test files simultaneously
tests/
├── test_core_logic.py          # All business logic tests
├── test_integrations.py        # All component interaction tests
├── test_edge_cases.py          # All boundary condition tests
└── test_error_handling.py      # All failure scenario tests
```

**Step 3: Dependency-Ordered Implementation**
```python
# Implement in dependency order, not test order
1. Data models and types
2. Core utility functions
3. Business logic functions
4. Integration layers
5. Error handling and validation
```

### **Workflow 2: Scenario Matrix Approach**

**Matrix Generation:**
```markdown
| Component | Happy Path | Edge Case | Error Case | Performance |
|-----------|------------|-----------|------------|-------------|
| email_validator | valid@email.com | edge@cases.co | invalid-email | 10k emails/sec |
| discount_calculator | standard_user | premium_user | negative_amount | bulk_calculations |
| file_processor | valid_file | empty_file | corrupted_file | large_files |
```

**Batch Test Generation:**
```python
# LLM fills entire matrix simultaneously
def generate_test_matrix():
    """Generate comprehensive test coverage using scenario matrix."""
    scenarios = {
        'happy_path': [...],
        'edge_cases': [...],
        'error_cases': [...],
        'performance': [...]
    }

    for component in components:
        for scenario_type, scenarios in scenarios.items():
            generate_tests(component, scenario_type, scenarios)
```

### **Workflow 3: Feature-Complete TDD**

**Step 1: Feature Specification**
```python
FEATURE_SPEC = {
    "name": "user_authentication",
    "functions": ["login", "logout", "register", "validate_session"],
    "constraints": {
        "security": "bcrypt hashing, session tokens",
        "performance": "<200ms response time",
        "reliability": "graceful failure handling"
    },
    "integrations": ["database", "email_service", "audit_log"]
}
```

**Step 2: Complete Test Suite Generation**
```python
# LLM generates all tests for entire feature
def test_user_authentication_complete():
    """Complete test suite for user authentication feature."""

    # Unit tests for each function
    test_login_valid_credentials()
    test_login_invalid_credentials()
    test_logout_active_session()
    test_register_new_user()
    # ... all permutations

    # Integration tests
    test_login_with_database()
    test_register_sends_email()
    test_audit_logging()

    # Performance tests
    test_login_performance()
    test_concurrent_sessions()

    # Security tests
    test_password_hashing()
    test_session_security()
```

## 🔧 Template-Driven Testing Patterns

### **Base Test Templates**

**Function Test Template:**
```python
def test_{function_name}_{scenario}() -> None:
    """Test {function_name} with {scenario} scenario."""
    # Given: Setup test data
    {setup_variables}

    # When: Execute function
    result = {function_name}({parameters})

    # Then: Validate results
    assert {primary_assertion}
    assert {secondary_assertions}

    # Additional validations
    {property_validations}
```

**Integration Test Template:**
```python
def test_{component_a}_integrates_with_{component_b}() -> None:
    """Test integration between {component_a} and {component_b}."""
    # Given: Mock external dependencies
    with patch("{external_service}") as mock_service:
        mock_service.return_value = {expected_response}

        # When: Execute integration
        result = {integration_function}({parameters})

        # Then: Validate integration
        assert {integration_assertions}
        mock_service.assert_called_with({expected_calls})
```

**Error Handling Template:**
```python
def test_{function_name}_handles_{error_type}() -> None:
    """Test {function_name} properly handles {error_type}."""
    # Given: Setup error condition
    {error_setup}

    # When/Then: Expect specific exception
    with pytest.raises({ExceptionType}) as exc_info:
        {function_name}({parameters})

    # Validate error details
    assert {error_message_validation}
    assert {error_state_validation}
```

### **Property-Based Test Templates**

**Invariant Validation Template:**
```python
@given(st.{appropriate_strategy}())
def test_{function_name}_invariants(input_data):
    """Test invariants that must always hold for {function_name}."""
    result = {function_name}(input_data)

    # Property 1: Output type consistency
    assert isinstance(result, {expected_type})

    # Property 2: Domain constraints
    assert {domain_constraint_check}

    # Property 3: Business rule compliance
    assert {business_rule_check}
```

## 📊 Scenario Matrix Implementation

### **Matrix Definition Framework**
```python
TEST_SCENARIOS = {
    "email_validation": {
        "valid_cases": [
            "user@domain.com",
            "test.email@subdomain.domain.co.uk",
            "user+tag@domain.org"
        ],
        "edge_cases": [
            "a@b.co",  # Minimal valid
            "very.long.email.address@very.long.domain.name.com",
            "user@domain-with-dash.com"
        ],
        "invalid_cases": [
            "",  # Empty
            "invalid",  # No @
            "@domain.com",  # No local part
            "user@",  # No domain
            "user@domain"  # No TLD
        ]
    }
}
```

### **Batch Test Generation**
```python
def generate_comprehensive_tests(function_name: str, scenarios: dict) -> None:
    """Generate all test cases for a function using scenario matrix."""

    for category, test_cases in scenarios.items():
        for i, test_case in enumerate(test_cases):
            test_function = f"""
def test_{function_name}_{category}_{i+1}() -> None:
    '''Test {function_name} with {category}: {test_case}'''
    # Given
    input_data = {repr(test_case)}
    expected = {get_expected_result(test_case, category)}

    # When
    result = {function_name}(input_data)

    # Then
    assert result == expected
"""
            write_test_function(test_function)
```

## 🛡️ Anti-Hallucination Patterns

### **Constraint-First Testing**
```python
def test_business_constraints() -> None:
    """Validate core business constraints are never violated."""

    # Constraint 1: Discounts never exceed 50%
    for discount_type in ["standard", "premium", "bulk"]:
        discount = calculate_discount(amount=1000, type=discount_type)
        assert discount.percentage <= 0.50

    # Constraint 2: Currency values always have 2 decimal places
    for amount in [10, 10.5, 10.99, 10.999]:
        formatted = format_currency(amount)
        assert len(formatted.split('.')[-1]) == 2

    # Constraint 3: User IDs are always positive integers
    for user_data in test_user_datasets:
        user = create_user(user_data)
        assert isinstance(user.id, int)
        assert user.id > 0
```

### **Cross-Function Consistency Validation**
```python
def test_function_consistency() -> None:
    """Ensure related functions maintain consistency."""

    # Test data flows correctly between functions
    user_data = {"email": "test@example.com", "name": "Test User"}

    # Chain function calls
    user = create_user(user_data)
    profile = get_user_profile(user.id)
    formatted_name = format_user_display_name(profile)

    # Validate consistency across the chain
    assert user.email == profile.email == user_data["email"]
    assert user.name in formatted_name
    assert profile.id == user.id
```

### **Type Safety Validation**
```python
def test_type_safety() -> None:
    """Validate all functions maintain type safety."""

    # Test all public functions have proper type hints
    for func in get_public_functions():
        signature = inspect.signature(func)

        # All parameters must have type hints
        for param in signature.parameters.values():
            assert param.annotation != inspect.Parameter.empty

        # Return type must be annotated
        assert signature.return_annotation != inspect.Signature.empty
```

## 🎯 Speed Optimization Techniques

### **Parallel Test Categories**
```python
# Generate test categories simultaneously
PARALLEL_TEST_GENERATION = {
    "unit_tests": lambda: generate_unit_tests(all_functions),
    "integration_tests": lambda: generate_integration_tests(all_components),
    "property_tests": lambda: generate_property_tests(all_constraints),
    "performance_tests": lambda: generate_performance_tests(critical_paths)
}

# LLM can process all categories in single thinking cycle
def generate_complete_test_suite():
    return {
        category: generator()
        for category, generator in PARALLEL_TEST_GENERATION.items()
    }
```

### **Smart Test Grouping**
```python
# Group related functionality for efficient batch processing
TEST_GROUPS = {
    "authentication": [
        "login", "logout", "register", "validate_session",
        "reset_password", "change_password"
    ],
    "user_management": [
        "create_user", "update_user", "delete_user",
        "get_user", "list_users"
    ],
    "data_processing": [
        "validate_input", "transform_data", "save_data",
        "generate_report", "export_results"
    ]
}

def generate_grouped_tests():
    """Generate tests for entire functional groups."""
    for group_name, functions in TEST_GROUPS.items():
        generate_group_test_suite(group_name, functions)
```

### **Template Inheritance for Speed**
```python
class BaseTestCase:
    """Base test case with common setup and utilities."""

    def setup_test_data(self) -> dict:
        """Standard test data setup."""
        return {
            "valid_user": {"email": "test@example.com", "name": "Test User"},
            "invalid_user": {"email": "invalid", "name": ""},
            "edge_case_user": {"email": "a@b.co", "name": "X"}
        }

    def assert_valid_response(self, response: dict) -> None:
        """Standard response validation."""
        assert "status" in response
        assert response["status"] in ["success", "error"]
        assert "data" in response or "error" in response

    def assert_error_response(self, response: dict, expected_error: str) -> None:
        """Standard error response validation."""
        assert response["status"] == "error"
        assert expected_error in response["error"]

# LLM inherits and customizes rather than rewriting common patterns
class TestUserAuthentication(BaseTestCase):
    def test_login_success(self):
        data = self.setup_test_data()
        response = login(data["valid_user"])
        self.assert_valid_response(response)
```

## 🔄 Prompt Engineering for Optimized TDD

### **Comprehensive Test Generation Prompts**
```markdown
"Generate complete test suite for {feature_name} using optimized TDD approach:

1. **Test Matrix**: Create scenario matrix covering:
   - Happy path cases (3-5 scenarios)
   - Edge cases (boundary conditions)
   - Error cases (invalid inputs, failures)
   - Performance cases (if applicable)

2. **Batch Implementation**: Generate all tests simultaneously using templates

3. **Property Validation**: Include tests that validate:
   - Type consistency
   - Business rule compliance
   - Cross-function consistency
   - Constraint adherence

4. **Anti-Hallucination**: Focus on concrete, verifiable assertions

Use established templates and maintain consistency with existing codebase patterns."
```

### **Context-Aware Test Design**
```markdown
"Analyze existing codebase patterns and generate tests that are consistent with:
- Error handling approaches used in similar functions
- Naming conventions for test functions and variables
- Type hint patterns and return value structures
- Mock and fixture patterns already established
- Assertion styles and validation approaches

Generate tests that feel native to this codebase."
```

### **Validation-First Prompting**
```markdown
"Before implementing {function_name}, design comprehensive validation tests that will catch any implementation errors:

1. **Constraint Tests**: What constraints must never be violated?
2. **Invariant Tests**: What properties must always hold?
3. **Integration Tests**: How should this function interact with others?
4. **Edge Case Tests**: What inputs could cause unexpected behavior?
5. **Performance Tests**: What are the performance requirements?

Then implement the function to satisfy all validation tests."
```

## 📈 Quality Metrics for Optimized TDD

### **Coverage Requirements**
- **Scenario Coverage**: 100% of scenario matrix must be tested
- **Branch Coverage**: ≥ 90% for business logic functions
- **Property Coverage**: All business constraints must have property tests
- **Integration Coverage**: All component interactions must be tested

### **Validation Checklist**
```python
def validate_test_suite_completeness():
    """Ensure optimized TDD approach maintains quality."""

    checks = {
        "all_functions_tested": check_function_coverage(),
        "all_scenarios_covered": check_scenario_matrix_coverage(),
        "all_constraints_validated": check_constraint_tests(),
        "all_integrations_tested": check_integration_coverage(),
        "no_hallucination_risks": check_anti_hallucination_patterns(),
        "performance_validated": check_performance_tests(),
        "type_safety_confirmed": check_type_safety_tests()
    }

    return all(checks.values())
```

## 🎯 Integration with Code Standards

### **Type Hints in Tests**
```python
# Maintain type safety in test code
def test_calculate_discount(
    user: User,
    purchase_amount: Decimal,
    expected_discount: Decimal,
) -> None:
    """Test discount calculation with full type safety."""
    result = calculate_discount(user=user, amount=purchase_amount)
    assert result.discount_amount == expected_discount
```

### **Docstring Standards for Tests**
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

### **Configuration Integration**
```toml
# pyproject.toml configuration for optimized TDD
[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = [
    "--strict-markers",
    "--cov=src",
    "--cov-branch",
    "--cov-report=term-missing",
    "--cov-fail-under=90",
    # Optimized TDD specific options
    "--tb=short",  # Faster failure reporting
    "--maxfail=5", # Stop after multiple failures
    "-v",          # Verbose for batch test validation
]

# Custom markers for optimized TDD
markers = [
    "unit: Unit tests for individual functions",
    "integration: Integration tests for component interaction",
    "property: Property-based tests for invariants",
    "performance: Performance and load tests",
    "anti_hallucination: Tests specifically designed to catch LLM errors"
]
```

This optimized approach leverages LLM strengths while maintaining rigorous quality standards, resulting in faster development cycles without sacrificing code reliability.