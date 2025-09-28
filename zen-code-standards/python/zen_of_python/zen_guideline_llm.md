# Zen of Python - Guideline Prático para Code Assistants

## **Objetivo**

Este guideline orienta LLMs/Code Assistants na implementação ativa de código Python seguindo rigorosamente os princípios do Zen of Python.

---

## **PARTE I: QUICK REFERENCE PARA LLM**

### **Decision Matrix - Priorização por Contexto**

| Contexto de Implementação | Princípios Primários | Princípios Secundários | Verificação Obrigatória |
|---------------------------|---------------------|------------------------|------------------------|
| **Escrevendo Função** | Readability counts<br>Simple > Complex | Explicit > Implicit<br>Flat > Nested | "Posso explicar em uma frase?" |
| **Estruturando Classe** | Explicit > Implicit<br>Namespaces | Simple > Complex<br>Beautiful > Ugly | "Responsabilidade única?" |
| **Organizando Módulo** | Namespaces<br>One obvious way | Flat > Nested<br>Sparse > Dense | "Imports claros?" |
| **Tratamento de Erro** | Errors never silent<br>Unless silenced | Explicit > Implicit<br>Refuse to guess | "Falha é óbvia?" |
| **Refatoração** | Readability counts<br>Simple > Complex | Beautiful > Ugly<br>Flat > Nested | "Melhorou a clareza?" |

### **Pre-Implementation Checklist**

**ANTES de gerar qualquer código, o LLM DEVE perguntar:**

#### **🔍 Grupo 1 - Fundações (OBRIGATÓRIO)**
- [ ] **Beautiful**: "Este código seguirá PEP 8 e convenções estabelecidas?"
- [ ] **Explicit**: "As intenções do código estarão claras sem conhecimento implícito?"
- [ ] **Readability**: "Um desenvolvedor conseguirá entender sem documentação?"

#### **🏗️ Grupo 2 - Estrutura (CRÍTICO)**
- [ ] **Simple**: "Estou usando a abordagem mais simples para este problema?"
- [ ] **Complex vs Complicated**: "Se complexo, é bem-arquitetado ou confuso?"
- [ ] **Flat**: "Posso evitar níveis desnecessários de aninhamento?"
- [ ] **Sparse**: "O código tem espaçamento adequado e não está denso?"

#### **⚖️ Grupo 3 - Decisões (QUANDO EM DÚVIDA)**
- [ ] **Special cases**: "Estou mantendo consistência mesmo em edge cases?"
- [ ] **Practicality**: "Há benefício prático claro para quebrar convenções?"
- [ ] **Ambiguity**: "Estou fazendo suposições ou sendo explícito?"
- [ ] **One way**: "Existe uma forma óbvia e Pythonic de fazer isso?"

### **Conflict Resolution Rules**

**Quando princípios entram em conflito, use esta hierarquia:**

1. **Readability SEMPRE vence** (nunca sacrifique legibilidade)
2. **Explicit > Implicit** quando há ambiguidade
3. **Simple > Complex** para problemas simples
4. **Practicality > Purity** quando há benefício claro e documentado
5. **Consistency > Cleverness** em casos especiais

### **Red Flags - Parar e Reconsiderar**

**Se encontrar estes sinais, PARE e repense:**

- 🚨 **"Isso é muito inteligente"** → Viola "Simple is better than complex"
- 🚨 **"Só funciona se você souber X"** → Viola "Explicit is better than implicit"
- 🚨 **"É hard-coded mas funciona"** → Viola "Special cases..."
- 🚨 **"Não sei explicar como funciona"** → Viola "Hard to explain = bad idea"
- 🚨 **"Tem 5+ níveis de if/for"** → Viola "Flat is better than nested"
- 🚨 **"Uma linha de 120+ caracteres"** → Viola "Sparse is better than dense"

---

## **PARTE II: GUIDANCE POR CONTEXTO DE IMPLEMENTAÇÃO**

### **📝 Escrevendo Funções**

#### **Aplicação dos Princípios:**
```python
# ✅ SEGUINDO ZEN
def calculate_user_discount(
    user: User,
    purchase_amount: float,
    loyalty_years: int,
) -> float:
    """Calculate discount based on user loyalty and purchase amount."""
    if not user.is_active:
        raise ValueError("Cannot calculate discount for inactive user")

    if purchase_amount <= 0:
        raise ValueError("Purchase amount must be positive")

    if loyalty_years < 0:
        raise ValueError("Loyalty years cannot be negative")

    base_discount = 0.0
    if loyalty_years >= 5:
        base_discount = 0.15
    elif loyalty_years >= 2:
        base_discount = 0.10
    elif loyalty_years >= 1:
        base_discount = 0.05

    volume_bonus = min(purchase_amount / 1000 * 0.01, 0.10)
    total_discount = base_discount + volume_bonus

    return min(total_discount, 0.25)  # Cap at 25%
```

#### **Checklist Específico para Funções:**
- [ ] **Nome explica claramente o que faz**
- [ ] **Parâmetros têm type hints**
- [ ] **Docstring existe e é clara**
- [ ] **Validação de entrada é explícita**
- [ ] **Lógica usa guard clauses (flat > nested)**
- [ ] **Retorno é óbvio e único**
- [ ] **Sem efeitos colaterais ocultos**

### **🏗️ Estruturando Classes**

#### **Aplicação dos Princípios:**
```python
# ✅ SEGUINDO ZEN
class UserDiscountCalculator:
    """Calculates discounts for users based on various criteria."""

    def __init__(
        self,
        max_discount: float = 0.25,
        loyalty_tiers: dict[int, float] | None = None,
    ) -> None:
        self.max_discount = max_discount
        self.loyalty_tiers = loyalty_tiers or {
            1: 0.05,
            2: 0.10,
            5: 0.15,
        }

    def calculate_discount(
        self,
        user: User,
        purchase_amount: float,
    ) -> float:
        """Calculate final discount for user and purchase."""
        self._validate_inputs(user=user, purchase_amount=purchase_amount)

        loyalty_discount = self._calculate_loyalty_discount(user=user)
        volume_discount = self._calculate_volume_discount(
            purchase_amount=purchase_amount,
        )

        total_discount = loyalty_discount + volume_discount
        return min(total_discount, self.max_discount)

    def _validate_inputs(self, user: User, purchase_amount: float) -> None:
        """Validate inputs for discount calculation."""
        if not user.is_active:
            raise ValueError("Cannot calculate discount for inactive user")
        if purchase_amount <= 0:
            raise ValueError("Purchase amount must be positive")

    def _calculate_loyalty_discount(self, user: User) -> float:
        """Calculate discount based on user loyalty years."""
        loyalty_years = user.loyalty_years

        for min_years in sorted(self.loyalty_tiers.keys(), reverse=True):
            if loyalty_years >= min_years:
                return self.loyalty_tiers[min_years]

        return 0.0

    def _calculate_volume_discount(self, purchase_amount: float) -> float:
        """Calculate discount based on purchase volume."""
        volume_bonus = purchase_amount / 1000 * 0.01
        return min(volume_bonus, 0.10)
```

#### **Checklist Específico para Classes:**
- [ ] **Responsabilidade única clara**
- [ ] **Nome da classe é substantivo descritivo**
- [ ] **Métodos públicos fazem uma coisa bem**
- [ ] **Métodos privados são helpers específicos**
- [ ] **Constructor valida estado inicial**
- [ ] **Type hints em todos os métodos**
- [ ] **Docstrings na classe e métodos públicos**

### **📦 Organizando Módulos**

#### **Estrutura Recomendada:**
```python
# user_management/discount_calculator.py
"""User discount calculation module.

This module provides functionality to calculate user discounts
based on loyalty and purchase volume.
"""

from decimal import Decimal
from typing import Protocol

from user_management.models import User
from user_management.exceptions import DiscountCalculationError


class DiscountRule(Protocol):
    """Protocol for discount calculation rules."""

    def calculate(self, user: User, amount: Decimal) -> Decimal:
        """Calculate discount amount."""
        ...


def calculate_user_discount(
    user: User,
    purchase_amount: Decimal,
    rules: list[DiscountRule],
) -> Decimal:
    """Main function to calculate user discount."""
    # Implementação da função principal
    ...


def _validate_discount_inputs(user: User, amount: Decimal) -> None:
    """Helper to validate discount calculation inputs."""
    # Implementação do helper
    ...


def _apply_discount_rules(
    user: User,
    amount: Decimal,
    rules: list[DiscountRule],
) -> Decimal:
    """Helper to apply multiple discount rules."""
    # Implementação do helper
    ...
```

#### **Checklist Específico para Módulos:**
- [ ] **Uma responsabilidade clara por módulo**
- [ ] **Docstring do módulo explica propósito**
- [ ] **Imports organizados (stdlib, third-party, local)**
- [ ] **Função principal no topo**
- [ ] **Helpers organizados por ordem de uso**
- [ ] **Nomes de arquivo são descritivos**
- [ ] **Não mais que 500 linhas (considere split)**

### **⚠️ Tratamento de Erros**

#### **Aplicação dos Princípios:**
```python
# ✅ SEGUINDO ZEN
def process_payment(
    payment_data: PaymentData,
    processor: PaymentProcessor,
) -> PaymentResult:
    """Process payment with explicit error handling."""
    try:
        # Validate inputs explicitly
        if not payment_data.amount > 0:
            raise ValueError("Payment amount must be positive")

        if not payment_data.currency:
            raise ValueError("Currency must be specified")

        # Process payment with clear error propagation
        result = processor.charge(
            amount=payment_data.amount,
            currency=payment_data.currency,
            source=payment_data.source,
        )

        if not result.success:
            raise PaymentProcessingError(
                f"Payment failed: {result.error_message}",
                error_code=result.error_code,
            )

        return result

    except PaymentNetworkError as e:
        # Explicitly handle network issues
        logger.error(f"Network error during payment: {e}")
        raise PaymentProcessingError(
            "Payment service temporarily unavailable",
        ) from e

    except PaymentValidationError as e:
        # Explicitly handle validation issues
        logger.warning(f"Payment validation failed: {e}")
        raise  # Re-raise validation errors as-is

    except Exception as e:
        # Never let unexpected errors pass silently
        logger.error(f"Unexpected error in payment processing: {e}")
        raise PaymentProcessingError(
            "An unexpected error occurred during payment processing",
        ) from e
```

#### **Checklist Específico para Tratamento de Erros:**
- [ ] **Validação de inputs é explícita e primeira**
- [ ] **Erros específicos têm exceções específicas**
- [ ] **Logs incluem contexto suficiente**
- [ ] **Never bare `except:` (sempre especifique)**
- [ ] **Re-raise com contexto quando necessário**
- [ ] **Falhas são óbvias para o chamador**

### **🔄 Refatoração**

#### **Processo Guiado pelo Zen:**

**ANTES da Refatoração:**
```python
# ❌ PROBLEMÁTICO
def calc(u, amt, t=None):
    if t is None: t = "standard"
    if u["type"] == "premium":
        if amt > 100:
            if t == "bulk": return amt * 0.8
            else: return amt * 0.9
        else: return amt * 0.95
    else:
        if amt > 50: return amt * 0.95
        else: return amt
```

**DEPOIS da Refatoração:**
```python
# ✅ SEGUINDO ZEN
def calculate_discounted_price(
    user: User,
    original_amount: Decimal,
    discount_type: str = "standard",
) -> Decimal:
    """Calculate final price after applying user-specific discounts."""
    if original_amount <= 0:
        raise ValueError("Original amount must be positive")

    if user.subscription_type == "premium":
        return _calculate_premium_discount(
            amount=original_amount,
            discount_type=discount_type,
        )

    return _calculate_standard_discount(amount=original_amount)


def _calculate_premium_discount(
    amount: Decimal,
    discount_type: str,
) -> Decimal:
    """Calculate discount for premium users."""
    if amount <= 100:
        return amount * Decimal("0.95")

    if discount_type == "bulk":
        return amount * Decimal("0.80")

    return amount * Decimal("0.90")


def _calculate_standard_discount(amount: Decimal) -> Decimal:
    """Calculate discount for standard users."""
    if amount > 50:
        return amount * Decimal("0.95")

    return amount
```

#### **Checklist Específico para Refatoração:**
- [ ] **Nomes são mais descritivos que antes**
- [ ] **Lógica está mais clara e explícita**
- [ ] **Aninhamento foi reduzido**
- [ ] **Responsabilidades foram separadas**
- [ ] **Type hints foram adicionados**
- [ ] **Validação foi tornada explícita**
- [ ] **Função principal virou orquestração**

---

## **PARTE III: TEMPLATES E PATTERNS**

### **🎯 Code Templates Baseados no Zen**

#### **Template: Função Simples**
```python
def {function_name}(
    {param1}: {Type1},
    {param2}: {Type2},
    {optional_param}: {Type3} = {default_value},
) -> {ReturnType}:
    """Brief description of what this function does.

    Args:
        param1: Description of param1
        param2: Description of param2
        optional_param: Description of optional parameter

    Returns:
        Description of return value

    Raises:
        ValueError: When input validation fails
        {SpecificError}: When specific condition occurs
    """
    # Validate inputs first (explicit > implicit)
    if not {validation_condition1}:
        raise ValueError("Clear error message about what's wrong")

    if not {validation_condition2}:
        raise ValueError("Another clear validation message")

    # Main logic (simple > complex)
    {main_logic}

    return {result}
```

#### **Template: Classe com Responsabilidade Única**
```python
class {ClassName}:
    """Brief description of the class responsibility.

    This class handles {specific_responsibility} and provides
    {main_functionality} for {target_use_case}.
    """

    def __init__(
        self,
        {required_param}: {Type1},
        {optional_param}: {Type2} | None = None,
    ) -> None:
        """Initialize {ClassName} with required configuration."""
        self._validate_init_params(
            {required_param}={required_param},
            {optional_param}={optional_param},
        )

        self.{required_param} = {required_param}
        self.{optional_param} = {optional_param} or {default_value}

    def {main_public_method}(
        self,
        {param}: {Type},
    ) -> {ReturnType}:
        """Main public interface method."""
        self._validate_{main_public_method}_inputs({param}={param})

        {step1_result} = self._step1({param})
        {step2_result} = self._step2({step1_result})

        return self._finalize_result({step2_result})

    def _validate_init_params(
        self,
        {required_param}: {Type1},
        {optional_param}: {Type2} | None,
    ) -> None:
        """Validate constructor parameters."""
        if not {validation_condition}:
            raise ValueError("Clear validation message")

    def _validate_{main_public_method}_inputs(self, {param}: {Type}) -> None:
        """Validate inputs for main method."""
        if not {condition}:
            raise ValueError("Clear validation message")

    def _step1(self, {param}: {Type}) -> {IntermediateType}:
        """First step of the main process."""
        # Implementation
        return {result}

    def _step2(self, {input}: {IntermediateType}) -> {AnotherType}:
        """Second step of the main process."""
        # Implementation
        return {result}

    def _finalize_result(self, {input}: {AnotherType}) -> {ReturnType}:
        """Final step to prepare the result."""
        # Implementation
        return {final_result}
```

#### **Template: Error Handling**
```python
def {function_with_error_handling}(
    {param}: {Type},
) -> {ReturnType}:
    """Function that handles errors explicitly."""
    try:
        # Validate inputs first
        if not {validation_condition}:
            raise ValueError("Explicit validation message")

        # Attempt the operation
        result = {risky_operation}({param})

        # Validate result if needed
        if not {result_validation}:
            raise {SpecificError}("Result validation failed")

        return result

    except {SpecificExpectedException} as e:
        # Handle specific known exceptions
        logger.warning(f"Expected error in {function_name}: {e}")
        raise {WrappedError}("User-friendly message") from e

    except {AnotherSpecificException} as e:
        # Handle another specific case
        logger.error(f"Critical error in {function_name}: {e}")
        # Decide: re-raise, wrap, or handle
        raise

    except Exception as e:
        # Never let unexpected errors pass silently
        logger.error(f"Unexpected error in {function_name}: {e}")
        raise {WrappedError}(
            "An unexpected error occurred during {operation}"
        ) from e
```

### **🚫 Anti-Patterns e Suas Correções**

#### **Anti-Pattern 1: Magic Numbers/Strings**
```python
# ❌ ANTI-PATTERN
def calculate_price(base_price):
    if base_price > 1000:
        return base_price * 0.9
    return base_price

# ✅ CORREÇÃO
BULK_DISCOUNT_THRESHOLD = 1000
BULK_DISCOUNT_RATE = 0.9

def calculate_price(base_price: Decimal) -> Decimal:
    """Calculate final price with bulk discount if applicable."""
    if base_price > BULK_DISCOUNT_THRESHOLD:
        return base_price * BULK_DISCOUNT_RATE
    return base_price
```

#### **Anti-Pattern 2: Deep Nesting**
```python
# ❌ ANTI-PATTERN
def process_user(user):
    if user:
        if user.is_active:
            if user.has_subscription:
                if user.subscription.is_valid():
                    if user.subscription.plan == "premium":
                        return process_premium_user(user)
                    else:
                        return process_standard_user(user)

# ✅ CORREÇÃO
def process_user(user: User | None) -> ProcessResult:
    """Process user with clear validation flow."""
    if not user:
        raise ValueError("User cannot be None")

    if not user.is_active:
        raise UserNotActiveError("User account is not active")

    if not user.has_subscription:
        raise NoSubscriptionError("User has no subscription")

    if not user.subscription.is_valid():
        raise InvalidSubscriptionError("User subscription is not valid")

    if user.subscription.plan == "premium":
        return process_premium_user(user)

    return process_standard_user(user)
```

#### **Anti-Pattern 3: Implicit Behavior**
```python
# ❌ ANTI-PATTERN
def save_user(user, db=None):
    db = db or get_default_db()
    # ... rest of implementation

# ✅ CORREÇÃO
def save_user(
    user: User,
    database: Database,
) -> None:
    """Save user to specified database.

    Args:
        user: User object to save
        database: Database connection to use for saving

    Raises:
        ValueError: If user is invalid
        DatabaseError: If save operation fails
    """
    if not user.is_valid():
        raise ValueError("Cannot save invalid user")

    database.save(user)

# Usage becomes explicit:
save_user(user=current_user, database=get_database())
```

#### **Anti-Pattern 4: Silent Failures**
```python
# ❌ ANTI-PATTERN
def parse_config(config_str):
    try:
        return json.loads(config_str)
    except:
        return {}

# ✅ CORREÇÃO
def parse_config(config_str: str) -> dict[str, Any]:
    """Parse configuration string into dictionary.

    Args:
        config_str: JSON string containing configuration

    Returns:
        Dictionary with parsed configuration

    Raises:
        ConfigParsingError: If config string is invalid JSON
        ValueError: If config_str is empty or None
    """
    if not config_str:
        raise ValueError("Configuration string cannot be empty")

    try:
        return json.loads(config_str)
    except json.JSONDecodeError as e:
        raise ConfigParsingError(
            f"Invalid JSON in configuration: {e}"
        ) from e
```

### **📏 Naming Conventions Baseadas no Zen**

#### **Explicit Naming Guidelines:**

**Functions:**
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

**Classes:**
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

**Variables:**
```python
# ✅ EXPLICIT
user_discount_percentage = 0.15
max_retry_attempts = 3
email_validation_pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

# ❌ IMPLICIT
discount = 0.15
max_retries = 3
pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
```

#### **Boolean Naming:**
```python
# ✅ CLEAR BOOLEAN INTENT
is_user_active: bool
has_valid_subscription: bool
can_process_payment: bool
should_send_notification: bool

# ❌ UNCLEAR BOOLEAN INTENT
user_active: bool
subscription: bool
payment: bool
notification: bool
```

---

## **PARTE IV: SELF-VERIFICATION PROMPTS**

### **🔍 Checklist Pós-Implementação para LLM**

**Após gerar código, o LLM DEVE perguntar a si mesmo:**

#### **Verificação Automática por Grupo**

##### **🎯 Grupo 1 - Fundações (CRÍTICO)**
```
✅ BEAUTIFUL:
- [ ] O código segue PEP 8 (indentação, espaçamento, line length)?
- [ ] Os nomes são consistentes com o padrão do projeto?
- [ ] A estrutura geral é limpa e organizada?

✅ EXPLICIT:
- [ ] Todas as intenções do código estão claras?
- [ ] Não há comportamentos "mágicos" ou implícitos?
- [ ] Alguém pode entender sem conhecimento especial?

✅ READABILITY:
- [ ] Um desenvolvedor júnior conseguiria entender este código?
- [ ] O código conta uma história clara?
- [ ] Evitei "cleverness" desnecessária?
```

##### **🏗️ Grupo 2 - Estrutura (CRÍTICO)**
```
✅ SIMPLE VS COMPLEX:
- [ ] Usei a solução mais simples possível para este problema?
- [ ] Se é complexo, é porque o problema é inerentemente complexo?
- [ ] Evitei over-engineering?

✅ FLAT:
- [ ] Há níveis desnecessários de aninhamento?
- [ ] Posso usar guard clauses ou early returns?
- [ ] A estrutura de controle é linear e clara?

✅ SPARSE:
- [ ] O código tem espaçamento adequado?
- [ ] Evitei linhas muito densas ou comprimidas?
- [ ] Quebrei expressões complexas em múltiplas linhas?
```

##### **⚖️ Grupo 3 - Decisões (QUANDO APLICÁVEL)**
```
✅ SPECIAL CASES:
- [ ] Mantive consistência mesmo em edge cases?
- [ ] Evitei criar soluções únicas para casos "especiais"?
- [ ] Segui os padrões estabelecidos?

✅ PRACTICALITY VS PURITY:
- [ ] Se quebrei alguma convenção, foi por benefício prático claro?
- [ ] Documentei a razão da exceção?
- [ ] O benefício justifica o desvio?

✅ AMBIGUITY:
- [ ] Evitei fazer suposições sobre inputs ou comportamento?
- [ ] Forcei clareza onde havia ambiguidade?
- [ ] Documentei suposições quando necessário?

✅ ONE WAY:
- [ ] Existe uma forma mais "Pythonic" de fazer isso?
- [ ] Estou seguindo convenções estabelecidas da linguagem?
- [ ] Evitei reinventar a roda?
```

### **🎯 Prompts de Auto-Avaliação Específicos**

#### **Para Funções:**
```
PERGUNTA OBRIGATÓRIA: "Se alguém me perguntar o que esta função faz,
posso explicar em uma frase clara?"

Se a resposta for NÃO → Refatore ou divida a função.

PERGUNTA TÉCNICA: "Esta função tem efeitos colaterais ocultos?"
Se SIM → Torne-os explícitos ou extraia em função separada.

PERGUNTA DE VALIDAÇÃO: "As validações de entrada são claras e completas?"
Se NÃO → Adicione validações explícitas no início.
```

#### **Para Classes:**
```
PERGUNTA DE RESPONSABILIDADE: "Esta classe tem uma única responsabilidade clara?"
Se NÃO → Considere dividir em classes menores.

PERGUNTA DE INTERFACE: "A interface pública é intuitiva e explícita?"
Se NÃO → Revise nomes de métodos e assinaturas.

PERGUNTA DE ESTADO: "O estado interno é gerenciado de forma clara?"
Se NÃO → Adicione validação no constructor e métodos.
```

#### **Para Módulos:**
```
PERGUNTA DE COESÃO: "Todas as funções/classes deste módulo pertencem ao mesmo contexto?"
Se NÃO → Considere dividir o módulo.

PERGUNTA DE IMPORTS: "Os imports são organizados e explícitos?"
Se NÃO → Organize em grupos (stdlib, third-party, local).

PERGUNTA DE TAMANHO: "O módulo tem menos de 500 linhas?"
Se NÃO → Considere split por responsabilidades.
```

### **🚨 Red Flags - Auto-Detecção**

**O LLM deve PARAR e reconsiderar se detectar:**

#### **Sintomas de Violação do Zen:**
```python
# 🚨 RED FLAG DETECTOR
def self_check_for_zen_violations():
    """Auto-verificação que o LLM deve executar mentalmente."""

    red_flags = {
        "implicit_behavior": [
            "Usei 'or' para defaults?",
            "Há comportamento baseado em truthiness?",
            "Algo funciona 'por acaso'?",
        ],
        "too_clever": [
            "Usei one-liners complexos?",
            "Há 'truques' de programação?",
            "Preciso explicar como funciona?",
        ],
        "nested_hell": [
            "Há mais de 3 níveis de if/for?",
            "A lógica forma uma 'escada'?",
            "Há muitos else aninhados?",
        ],
        "silent_failures": [
            "Há bare 'except:'?",
            "Retorno None em caso de erro?",
            "Erro é ignorado silenciosamente?",
        ],
        "naming_issues": [
            "Nomes são abreviados sem razão?",
            "Variáveis têm nomes genéricos (data, info, etc)?",
            "Funções não descrevem o que fazem?",
        ],
    }

    # Se QUALQUER red flag for True, PARE e refatore
    return red_flags
```

### **✅ Auto-Approval Checklist**

**O LLM só deve finalizar o código se ALL items abaixo forem TRUE:**

#### **Checklist Final (Todos OBRIGATÓRIOS):**
```
FUNDAMENTALS:
✅ [ ] Código segue PEP 8 automaticamente
✅ [ ] Todas as intenções são explícitas
✅ [ ] Legibilidade foi priorizada sobre cleverness

STRUCTURE:
✅ [ ] Solução é simples para o problema dado
✅ [ ] Estrutura é plana (sem nesting desnecessário)
✅ [ ] Código é bem espaçado e não denso

PRAGMATISM:
✅ [ ] Consistência foi mantida
✅ [ ] Ambiguidades foram evitadas
✅ [ ] Uma forma óbvia foi escolhida

ERRORS:
✅ [ ] Erros nunca passam silenciosamente
✅ [ ] Quando suprimidos, é explicitamente intencional

IMPLEMENTATION:
✅ [ ] Código foi entregue (not perfect is enemy of good)
✅ [ ] Mas não foi rushed (qualidade mantida)
✅ [ ] Implementação é fácil de explicar

ORGANIZATION:
✅ [ ] Namespaces são usados efetivamente
```

**Se QUALQUER item for ❌ → Continue refatorando até ALL sejam ✅**

### **🔄 Processo de Auto-Correção**

```python
def zen_guided_development_loop():
    """Processo mental que o LLM deve seguir."""

    while not all_zen_principles_satisfied():

        # 1. Identifique o maior problema
        main_issue = identify_primary_zen_violation()

        # 2. Aplique correção específica
        if main_issue == "readability":
            improve_naming_and_structure()
        elif main_issue == "complexity":
            simplify_or_break_down()
        elif main_issue == "nesting":
            flatten_with_guard_clauses()
        elif main_issue == "implicit":
            make_intentions_explicit()

        # 3. Re-execute checklist
        run_self_verification()

        # 4. Se ainda há problemas, continue loop

    # 5. Só saia quando ALL verificações passarem
    return finalized_code
```

---

## **PARTE V: INTEGRATION INSTRUCTIONS**

### **🚀 Como Usar Este Guideline**

#### **Para LLMs/Code Assistants:**

##### **1. Workflow de Implementação**
```
📋 FASE PRÉ-CÓDIGO:
1. Leia o contexto e requisitos
2. Execute "Pre-Implementation Checklist" (Parte I)
3. Identifique contexto na "Decision Matrix" (Parte I)
4. Consulte orientações específicas (Parte II)

⚙️ FASE DE CÓDIGO:
1. Use templates apropriados (Parte III)
2. Aplique naming conventions (Parte III)
3. Evite anti-patterns conhecidos (Parte III)
4. Execute auto-verificação contínua (Parte IV)

✅ FASE PÓS-CÓDIGO:
1. Execute "Self-Verification Prompts" completo (Parte IV)
2. Execute "Auto-Approval Checklist" (Parte IV)
3. Se falhar algum item → Loop de correção (Parte IV)
4. Só finalize quando ALL checks passarem
```

##### **2. Quick Reference Integration**
```python
# MENTAL TEMPLATE PARA LLM
def generate_python_code(user_request):
    """Template mental para implementação guiada pelo Zen."""

    # 1. PRÉ-ANÁLISE (OBRIGATÓRIA)
    context = identify_implementation_context(user_request)
    primary_principles = get_primary_principles(context)

    # 2. IMPLEMENTAÇÃO GUIADA
    code = implement_with_zen_guidance(
        request=user_request,
        context=context,
        principles=primary_principles,
    )

    # 3. VERIFICAÇÃO AUTOMÁTICA
    while not passes_all_zen_checks(code):
        violations = detect_zen_violations(code)
        code = fix_zen_violations(code, violations)

    # 4. APROVAÇÃO FINAL
    if passes_auto_approval_checklist(code):
        return code
    else:
        return generate_python_code(user_request)  # Restart
```

##### **3. Integração com Prompts**

**Prompt Prefix Sugerido:**
```
You are a Python code assistant that STRICTLY follows the Zen of Python principles.

BEFORE writing any code, you MUST:
1. Check Pre-Implementation Checklist (focus on Beautiful, Explicit, Readability)
2. Identify implementation context (function, class, module, error handling, refactor)
3. Choose appropriate templates and patterns

WHILE writing code, you MUST:
1. Apply explicit naming conventions
2. Use flat structures over nested ones
3. Make all intentions clear and unambiguous
4. Handle errors explicitly

AFTER writing code, you MUST:
1. Run complete Self-Verification Prompts
2. Check for Red Flags
3. Execute Auto-Approval Checklist
4. Only submit code that passes ALL checks

If ANY verification fails, fix the issues and re-check until ALL pass.
```

### **📖 Usage Instructions por Fase do Desenvolvimento**

#### **🔨 Nova Feature**
```
CONTEXTO: Implementando funcionalidade nova
PRINCÍPIOS PRIMÁRIOS: Simple > Complex, Explicit > Implicit, Readability
TEMPLATES: Função Simples ou Classe com Responsabilidade Única
VERIFICAÇÃO ESPECIAL:
- "Posso explicar esta feature em uma frase?"
- "A interface é intuitiva?"
- "Segui o padrão do projeto?"
```

#### **🔧 Refatoração**
```
CONTEXTO: Melhorando código existente
PRINCÍPIOS PRIMÁRIOS: Readability, Flat > Nested, Beautiful > Ugly
TEMPLATES: Análise de Anti-Patterns primeiro
VERIFICAÇÃO ESPECIAL:
- "O código ficou mais claro que antes?"
- "Reduzi complexidade desnecessária?"
- "Mantive funcionalidade original?"
```

#### **🐛 Bug Fix**
```
CONTEXTO: Corrigindo problemas
PRINCÍPIOS PRIMÁRIOS: Errors never silent, Explicit > Implicit
TEMPLATES: Error Handling Template
VERIFICAÇÃO ESPECIAL:
- "A causa do bug está clara agora?"
- "Adicionei validação para prevenir recorrência?"
- "O fix é targeted e não over-engineering?"
```

#### **🧪 Teste/Debug**
```
CONTEXTO: Testando ou debugando
PRINCÍPIOS PRIMÁRIOS: Explicit > Implicit, Flat > Nested
TEMPLATES: Função Simples para helpers de teste
VERIFICAÇÃO ESPECIAL:
- "Os testes são claros sobre o que validam?"
- "Nomes dos testes explicam o cenário?"
- "Debug helpers são autoexplicativos?"
```

### **⚙️ Customização do Guideline**

#### **Para Projetos Específicos:**

**Adicione seção personalizada:**
```markdown
## PROJECT-SPECIFIC ZEN ADAPTATIONS

### Our Team's Zen Priorities:
1. [Principal específico do projeto]
2. [Convenção específica da equipe]
3. [Padrão específico do domínio]

### Custom Templates:
- [Template específico para seu domínio]
- [Padrão específico da arquitetura]

### Project Red Flags:
- [Anti-pattern específico do projeto]
- [Violação específica que a equipe quer evitar]
```

#### **Para Domínios Específicos:**

**Machine Learning:**
```python
# Zen-guided ML function template
def train_model(
    dataset: pd.DataFrame,
    target_column: str,
    model_config: ModelConfig,
) -> TrainedModel:
    """Train ML model with explicit validation and error handling."""
    # Explicit validation
    if dataset.empty:
        raise ValueError("Dataset cannot be empty")

    # Clear preprocessing steps
    clean_data = preprocess_dataset(dataset)
    features, target = extract_features_and_target(
        data=clean_data,
        target_column=target_column,
    )

    # Explicit model training
    model = initialize_model(config=model_config)
    trained_model = model.fit(features=features, target=target)

    return trained_model
```

**Web APIs:**
```python
# Zen-guided API endpoint template
@app.post("/users/{user_id}/discount")
def calculate_user_discount(
    user_id: int,
    discount_request: DiscountRequest,
    db: Database = Depends(get_database),
) -> DiscountResponse:
    """Calculate discount for specific user."""
    # Explicit validation
    user = get_user_or_404(user_id=user_id, db=db)
    validate_discount_request(request=discount_request)

    # Clear business logic
    discount = calculate_discount(
        user=user,
        amount=discount_request.amount,
    )

    # Explicit response
    return DiscountResponse(
        user_id=user_id,
        original_amount=discount_request.amount,
        discount_amount=discount.amount,
        final_amount=discount.final_amount,
    )
```

### **🎯 Success Metrics**

**Para medir efetividade do guideline:**

#### **Métricas de Código:**
- **Readability Score**: Código pode ser entendido sem documentação?
- **Complexity Reduction**: Níveis de aninhamento diminuíram?
- **Explicit Ratio**: % de comportamentos explícitos vs implícitos
- **Error Handling Coverage**: % de funções com error handling adequado

#### **Métricas de Processo:**
- **Review Speed**: Code reviews ficaram mais rápidas?
- **Bug Rate**: Menos bugs relacionados a código confuso?
- **Onboarding Time**: Novos devs entendem código mais rápido?
- **Consistency Score**: Código segue padrões estabelecidos?

#### **Auto-Avaliação para LLM:**
```python
def measure_zen_compliance(generated_code: str) -> ZenScorecard:
    """Measure how well code follows Zen principles."""
    return ZenScorecard(
        beautiful_score=check_pep8_compliance(generated_code),
        explicit_score=measure_code_clarity(generated_code),
        simple_score=analyze_complexity(generated_code),
        flat_score=count_nesting_levels(generated_code),
        readable_score=assess_readability(generated_code),
        error_handling_score=check_error_patterns(generated_code),
    )
```

---

## **🎉 RESUMO EXECUTIVO**

### **Para LLMs:**

Este guideline transforma o Zen of Python de filosofia em **ferramenta prática de implementação**.

**Use-o como:**
1. **Checklist pré-implementação** → Parte I
2. **Guia durante implementação** → Parte II + III
3. **Verificação pós-implementação** → Parte IV
4. **Integração no workflow** → Parte V

**Regra de ouro:** Se passar por TODAS as verificações deste guideline, seu código estará alinhado com o Zen of Python e será **legível, maintível e Pythonic**.

**Lembre-se:** O objetivo é código que **conta uma história clara** e **pode ser facilmente entendido** por qualquer desenvolvedor Python.

---

**Documentos relacionados:**
- [Teoria e educação](zen_theory_explained.md)
- [Referência rápida](zen_quick_reference.md)