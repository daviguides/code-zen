# Python Quick Reference

## Setup & Tools
- **Python ≥ 3.13** (sem `__future__` imports)
- **uv** para dependências (não pip/poetry)
- **Ruff** para formatação + **80 colunas** máximo

## Type System
- **Type hints sempre** (funções, classes, vars quando necessário)
- **Trailing commas** em assinaturas/chamadas
- **Sintaxe Python 3.13+** (`list[str]` vs `List[str]`)

## Function Calls & Style
- **kwargs** para múltiplos argumentos
- **Múltiplas linhas** para +1 argumento
- **f-strings sempre** (não `%` ou `.format()`)

## Imports & Paths
- **pathlib** vs `os.path`
- **3 grupos** de imports: stdlib, third-party, local
- **Linhas em branco** entre grupos

## Package Structure
- **Evite `__init__.py` vazios** - não obrigatórios desde Python 3.3 (PEP 420)
- **Use apenas para aliases** e exports explícitos

```python
# ✅ Com aliases úteis
from .module import Class, function

__all__ = [
    "Class",
    "function",
]

# ❌ Arquivo vazio desnecessário
# __init__.py (empty file)
```

## Documentation & Constants
- **Docstrings obrigatórias** (módulos, classes, funções)
- **≤ 80 colunas** com quebras quando necessário
- **Evitar magic numbers** (usar constantes/config)

## Queries & Long Strings
- **SQL em múltiplas linhas** com triple quotes
- **Quebrar strings longas** para legibilidade

## Integration Philosophy
- **Async-first** quando faz sentido
- **Performance-focused** libraries
- **Type hints support** obrigatório

