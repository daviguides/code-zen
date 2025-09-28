# Zen of Python - Quick Reference Card

## **🎯 Decision Matrix - Priorização por Contexto**

| Contexto | Princípios Primários | Verificação Rápida |
|----------|---------------------|-------------------|
| **Função** | Readability, Simple > Complex | "1 frase explica o que faz?" |
| **Classe** | Explicit > Implicit, Single Responsibility | "Responsabilidade única?" |
| **Módulo** | Namespaces, One obvious way | "Imports claros?" |
| **Erro** | Never silent, Unless silenced | "Falha é óbvia?" |
| **Refactor** | Readability, Flat > Nested | "Melhorou clareza?" |

## **⚡ Pre-Code Checklist (OBRIGATÓRIO)**

**Antes de gerar qualquer código:**
- [ ] **Beautiful**: Segue PEP 8?
- [ ] **Explicit**: Intenções claras?
- [ ] **Readable**: Desenvolvedor entende sem docs?
- [ ] **Simple**: Abordagem mais simples possível?
- [ ] **Flat**: Evita aninhamento desnecessário?

## **🚨 Red Flags Instantâneos**

**PARE se encontrar:**
- **"Isso é muito inteligente"** → Muito complex
- **"Só funciona se souber X"** → Muito implicit
- **"5+ níveis de if/for"** → Muito nested
- **"Linha 120+ chars"** → Muito dense
- **"Não sei explicar"** → Hard to explain

## **✅ Conflict Resolution**

**Hierarquia de desempate:**
1. **Readability SEMPRE vence**
2. **Explicit > Implicit** (quando ambíguo)
3. **Simple > Complex** (problemas simples)
4. **Practicality > Purity** (benefício claro)
5. **Consistency > Cleverness** (casos especiais)

## **🎯 Auto-Verification (Pós-Código)**

**Perguntas obrigatórias:**

### **Para Funções:**
- "Explico em 1 frase o que faz?" → Se NÃO: refatore
- "Tem efeitos colaterais ocultos?" → Se SIM: explicite
- "Validações são claras?" → Se NÃO: adicione

### **Para Classes:**
- "Responsabilidade única?" → Se NÃO: divida
- "Interface intuitiva?" → Se NÃO: renomeie
- "Estado bem gerenciado?" → Se NÃO: valide

### **Para Módulos:**
- "Tudo pertence ao contexto?" → Se NÃO: reorganize
- "Imports organizados?" → Se NÃO: agrupe
- "Menos de 500 linhas?" → Se NÃO: divida

## **📏 Naming Cheat Sheet**

### **Functions:**
```python
# ✅ GOOD
def calculate_user_discount(user, amount): ...
def validate_email_format(email): ...

# ❌ BAD
def calc(u, a): ...
def validate(email): ...
```

### **Classes:**
```python
# ✅ GOOD
class EmailValidator: ...
class UserDiscountCalculator: ...

# ❌ BAD
class Validator: ...
class Calculator: ...
```

### **Booleans:**
```python
# ✅ GOOD
is_user_active: bool
has_valid_subscription: bool
can_process_payment: bool

# ❌ BAD
user_active: bool
subscription: bool
payment: bool
```

## **🛠️ Essential Templates**

### **Simple Function:**
```python
def function_name(
    param1: Type1,
    param2: Type2,
) -> ReturnType:
    """What this function does."""
    # Validate inputs first
    if not param1:
        raise ValueError("Clear message")

    # Main logic
    result = do_something(param1, param2)

    return result
```

### **Error Handling:**
```python
try:
    # Validate first
    if not valid_input:
        raise ValueError("Clear message")

    # Do risky operation
    result = risky_operation()

    return result

except SpecificError as e:
    logger.error(f"Context: {e}")
    raise WrappedError("User message") from e
```

### **Guard Clauses (Flat > Nested):**
```python
# ✅ FLAT
def process_user(user):
    if not user:
        raise ValueError("User required")
    if not user.is_active:
        raise UserError("User inactive")
    if not user.has_subscription:
        raise SubscriptionError("No subscription")

    # Main logic here
    return process(user)

# ❌ NESTED
def process_user(user):
    if user:
        if user.is_active:
            if user.has_subscription:
                return process(user)
```

## **🔄 Quick Self-Check Loop**

```python
def mental_checklist():
    """Execute antes de finalizar código."""
    while True:
        if not follows_pep8(): fix_formatting()
        if not explicit_intent(): clarify_behavior()
        if not readable(): improve_names()
        if too_complex(): simplify()
        if too_nested(): flatten()
        if silent_errors(): add_explicit_handling()
        if hard_to_explain(): refactor()

        if all_zen_checks_pass():
            break

    return approved_code
```

## **📊 Final Approval Checklist**

**ALL items MUST be ✅ before submitting:**

```
FUNDAMENTALS:
✅ [ ] PEP 8 compliant
✅ [ ] Explicit intentions
✅ [ ] Prioritized readability

STRUCTURE:
✅ [ ] Simple solution
✅ [ ] Flat structure
✅ [ ] Well-spaced code

PRAGMATISM:
✅ [ ] Consistent approach
✅ [ ] No ambiguity
✅ [ ] Obvious way chosen

ERRORS:
✅ [ ] No silent failures
✅ [ ] Explicit when suppressed

IMPLEMENTATION:
✅ [ ] Code delivered
✅ [ ] Quality maintained
✅ [ ] Easy to explain

ORGANIZATION:
✅ [ ] Namespaces used effectively
```

---

## **💡 Remember**

**Zen Golden Rule:** If code passes ALL these checks → it's Pythonic ✅

**Core Philosophy:** Write code that **tells a clear story** and can be **easily understood** by any Python developer.

