# TDD Guidelines for Python Projects

## 🔴 Red-Green-Refactor Cycle

### **1. Red - Write Failing Test First**
```python
def test_calculate_discount_for_premium_user(
    premium_user: User,
    purchase_amount: Decimal,
) -> None:
    """Test discount calculation for premium users."""
    # Arrange
    expected_discount = Decimal("0.15")

    # Act
    result = calculate_discount(
        user=premium_user,
        amount=purchase_amount,
    )

    # Assert
    assert result.discount_rate == expected_discount
    assert result.final_amount < purchase_amount
```

### **2. Green - Minimal Implementation**
```python
def calculate_discount(
    user: User,
    amount: Decimal,
) -> DiscountResult:
    """Calculate discount for user purchase."""
    # Minimal implementation to make test pass
    if user.is_premium:
        discount_rate = Decimal("0.15")
    else:
        discount_rate = Decimal("0.00")

    final_amount = amount * (Decimal("1") - discount_rate)

    return DiscountResult(
        discount_rate=discount_rate,
        final_amount=final_amount,
    )
```

### **3. Refactor - Improve Without Breaking**
```python
def calculate_discount(
    user: User,
    amount: Decimal,
) -> DiscountResult:
    """Calculate discount based on user tier and purchase amount."""
    discount_rate = _get_user_discount_rate(user)
    bulk_discount = _calculate_bulk_discount(amount)

    total_discount = min(discount_rate + bulk_discount, Decimal("0.50"))
    final_amount = amount * (Decimal("1") - total_discount)

    return DiscountResult(
        discount_rate=total_discount,
        final_amount=final_amount,
    )
```

## 🧪 Test Structure Patterns

### **AAA Pattern (Arrange-Act-Assert)**
```python
def test_user_authentication_success() -> None:
    """Test successful user authentication."""
    # Arrange
    email = "user@example.com"
    password = "secure_password"
    user_service = UserService()

    # Act
    result = user_service.authenticate(
        email=email,
        password=password,
    )

    # Assert
    assert result.is_authenticated is True
    assert result.user.email == email
```

### **Given-When-Then (BDD Style)**
```python
def test_order_processing_with_insufficient_stock() -> None:
    """Test order processing when stock is insufficient."""
    # Given
    product = Product(name="Widget", stock=5)
    order_quantity = 10

    # When
    with pytest.raises(InsufficientStockError) as exc_info:
        process_order(
            product=product,
            quantity=order_quantity,
        )

    # Then
    assert "insufficient stock" in str(exc_info.value).lower()
    assert product.stock == 5  # Stock unchanged
```

### **Fixtures for Test Data**
```python
@pytest.fixture
def sample_user() -> User:
    """Create sample user for testing."""
    return User(
        email="test@example.com",
        is_premium=False,
        created_at=datetime.now(),
    )

@pytest.fixture
def premium_user() -> User:
    """Create premium user for testing."""
    return User(
        email="premium@example.com",
        is_premium=True,
        created_at=datetime.now(),
    )
```

## 🏗️ Testing Architecture

### **Test Organization by Feature**
```
tests/
├── unit/
│   ├── auth/
│   │   ├── test_user_service.py
│   │   └── test_auth_validators.py
│   ├── orders/
│   │   ├── test_order_service.py
│   │   └── test_payment_processor.py
│   └── utils/
│       └── test_formatters.py
├── integration/
│   ├── test_api_endpoints.py
│   └── test_database_operations.py
└── e2e/
    └── test_user_workflows.py
```

### **Test Types and Scope**

#### **Unit Tests - Single Function/Method**
```python
def test_format_currency_brazilian_locale() -> None:
    """Test currency formatting for Brazilian locale."""
    amount = Decimal("1234.56")

    result = format_currency(amount, locale="pt_BR")

    assert result == "R$ 1.234,56"
```

#### **Integration Tests - Multiple Components**
```python
def test_user_registration_workflow() -> None:
    """Test complete user registration process."""
    user_data = {
        "email": "new@example.com",
        "password": "secure_password",
    }

    # Test registration through API
    response = client.post("/api/register", json=user_data)

    assert response.status_code == 201
    assert response.json()["email"] == user_data["email"]

    # Verify user exists in database
    user = db.query(User).filter_by(email=user_data["email"]).first()
    assert user is not None
```

#### **End-to-End Tests - Full User Journey**
```python
def test_complete_purchase_flow() -> None:
    """Test complete purchase workflow."""
    # User registration → Login → Add to cart → Checkout → Payment
    pass  # Implementation depends on specific application
```

## 📐 Quality Standards

### **Coverage Requirements**
- **Unit tests**: ≥ 90% coverage for business logic
- **Integration tests**: ≥ 75% coverage for API endpoints
- **Overall project**: ≥ 80% coverage minimum

### **Test Naming Conventions**
```python
# ✅ GOOD - Descriptive test names
def test_calculate_discount_returns_zero_for_basic_user() -> None: ...
def test_authenticate_user_raises_error_for_invalid_password() -> None: ...
def test_process_order_updates_inventory_correctly() -> None: ...

# ❌ BAD - Vague test names
def test_discount() -> None: ...
def test_auth() -> None: ...
def test_order() -> None: ...
```

### **Error Boundary Testing**
```python
def test_handle_database_connection_failure() -> None:
    """Test graceful handling of database failures."""
    with patch("app.database.connect") as mock_connect:
        mock_connect.side_effect = ConnectionError("Database unavailable")

        with pytest.raises(ServiceUnavailableError):
            user_service.get_user(user_id=123)

def test_handle_external_api_timeout() -> None:
    """Test handling of external API timeouts."""
    with patch("requests.get") as mock_get:
        mock_get.side_effect = requests.Timeout()

        result = payment_service.process_payment(payment_data)

        assert result.status == "retry_later"
```

## 🤖 LLM-Specific TDD Patterns

### **Test-First Prompting**
```markdown
"Write a test for a function that validates email format according to RFC 5322,
then implement the function to make the test pass."

# LLM writes test first, then implementation
```

### **Validation-Driven Development**
```python
def test_llm_generated_function_behavior() -> None:
    """Validate LLM-generated function behaves correctly."""
    # Test edge cases that LLM might miss
    test_cases = [
        ("", False),  # Empty string
        ("invalid", False),  # No @ symbol
        ("@domain.com", False),  # Missing local part
        ("user@", False),  # Missing domain
        ("user@domain.com", True),  # Valid email
    ]

    for email, expected in test_cases:
        assert validate_email(email) == expected
```

### **Mock-First Approach for External Dependencies**
```python
@pytest.fixture
def mock_external_api():
    """Mock external API responses for consistent testing."""
    with patch("app.services.external_api") as mock_api:
        mock_api.get_user_data.return_value = {
            "id": 123,
            "name": "Test User",
            "email": "test@example.com",
        }
        yield mock_api

def test_user_service_with_mocked_api(mock_external_api) -> None:
    """Test user service with mocked external dependencies."""
    user_service = UserService()

    result = user_service.get_user_profile(user_id=123)

    assert result.name == "Test User"
    mock_external_api.get_user_data.assert_called_once_with(123)
```

## 🔄 Integration with Code Standards

### **Type Hints in Tests**
```python
# ✅ GOOD - Type hints for test clarity
def test_process_orders(
    orders: list[Order],
    expected_total: Decimal,
) -> None:
    """Test order processing with type safety."""
    result = process_orders(orders)
    assert result.total == expected_total

# ❌ AVOID - Untyped tests
def test_process_orders(orders, expected_total):
    pass
```

### **Following Naming Conventions**
```python
# ✅ GOOD - Clear, descriptive names
class TestUserAuthenticationService:
    """Test suite for user authentication service."""

    def test_authenticate_user_with_valid_credentials(self) -> None: ...
    def test_authenticate_user_with_invalid_password(self) -> None: ...
    def test_authenticate_user_with_nonexistent_email(self) -> None: ...

# Test files: test_user_authentication.py, test_order_processing.py
```

### **Docstrings for Test Classes and Methods**
```python
class TestPaymentProcessor:
    """Test suite for payment processing functionality.

    Tests cover various payment scenarios including successful payments,
    failed transactions, and error handling.
    """

    def test_process_credit_card_payment_success(self) -> None:
        """Test successful credit card payment processing.

        Verifies that valid credit card data results in successful
        payment and proper response formatting.
        """
        pass
```

## 📊 Running Tests

### **Test Commands**
```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src --cov-report=term-missing

# Run specific test file
pytest tests/unit/test_user_service.py

# Run tests matching pattern
pytest -k "test_authentication"

# Run with verbose output
pytest -v
```

### **Configuration in pyproject.toml**
```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = [
    "--strict-markers",
    "--strict-config",
    "--cov=src",
    "--cov-branch",
    "--cov-report=term-missing",
]
```

Este approach garante **código robusto e maintanable** através de TDD sistemático, especialmente importante quando working com Code Assistants/LLMs.