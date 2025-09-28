# Python Specific Rules - Regras Específicas para Python

## **Versão e Dependências**

### **🐍 Python Moderno**
- Use **Python ≥ 3.13** sempre.
- **Nunca adicione `from __future__ import annotations`** ou qualquer outro import do `__future__` em projetos Python ≥ 3.13.
- **Sempre utilize a sintaxe moderna de type hints nativa do Python 3.13+.**

### **📦 Gerenciamento de Dependências**
- **Gerencie dependências com `uv`**; **não** use `pip` nem `poetry`.
- Mantenha `pyproject.toml` atualizado com dependências e configurações.

#### **Exemplo de setup com uv:**
```bash
# Iniciar projeto
uv init my_project
cd my_project

# Adicionar dependências
uv add requests pydantic

# Adicionar dependências de desenvolvimento
uv add --dev pytest black ruff mypy

# Rodar projeto
uv run python main.py
```

## **Formatação e Estilo**

### **⚡ Ruff para Formatação**
- **Formate o código e os imports com Ruff** sempre.
- **Nunca ultrapasse 80 colunas** de largura.
- Configure Ruff no `pyproject.toml`:

```toml
[tool.ruff]
line-length = 80
target-version = "py312"

[tool.ruff.lint]
select = ["E", "F", "I", "N", "W", "UP"]
```

### **📏 Limites de Linha**
- **80 colunas máximo** para compatibilidade com terminais e code reviews.
- **Quebre linhas longas** de forma legível.
- **Use trailing commas** para facilitar diffs.

## **Tipagem**

### **🏷️ Type Hints Obrigatórios**
- **Use type hints sempre** em:
  - **Assinaturas de funções** (parâmetros e retorno)
  - **Variáveis de classe**
  - **Outras variáveis quando necessário para clareza**

### **📝 Assinaturas de Função**
- Quando uma função tiver **mais de um argumento**, **quebre a assinatura em múltiplas linhas**.
- **Coloque vírgula após o último argumento** (trailing comma).

#### **Exemplo correto:**
```python
def calculate_user_discount(
    user: User,
    purchase_amount: Decimal,
    loyalty_years: int,
    discount_type: str = "standard",
) -> Decimal:
    """Calculate discount based on user and purchase details."""
    ...
```

### **🆕 Python 3.13+ Type Syntax**
```python
# ✅ CORRETO - Sintaxe nativa Python 3.13+
def process_items(
    items: list[dict[str, Any]],
    config: dict[str, str | int],
) -> list[ProcessedItem]:
    ...

# ❌ ERRADO - Sintaxe antiga
from typing import List, Dict, Union, Any

def process_items(
    items: List[Dict[str, Any]],
    config: Dict[str, Union[str, int]],
) -> List[ProcessedItem]:
    ...
```

## **Chamadas de Função**

### **🔑 Keyword Arguments**
- **Use keyword arguments (kwargs)** sempre que houver **mais de um argumento**.
- Se houver apenas um argumento, **use keyword quando aumentar a clareza semântica**.
- **Quebre chamadas em múltiplas linhas** quando houver mais de um argumento.
- **Sempre adicione vírgula final** após o último argumento (trailing comma).

#### **Exemplos:**
```python
# ✅ MÚLTIPLOS ARGUMENTOS - sempre kwargs e múltiplas linhas
result = calculate_discount(
    user=current_user,
    amount=purchase_total,
    discount_type="premium",
    apply_taxes=True,
)

# ✅ ARGUMENTO ÚNICO - keyword quando melhora clareza
user = get_user(user_id=123)  # Mais claro
data = serialize(obj)         # Óbvio sem keyword

# ❌ ERRADO - múltiplos args sem keywords
result = calculate_discount(current_user, purchase_total, "premium", True)
```

## **Strings e Formatação**

### **🔤 F-strings Always**
- **Use f-strings sempre**; **não** use `%` nem `.format()`.
- F-strings são mais legíveis e performáticos.

#### **Exemplos:**
```python
# ✅ CORRETO
message = f"User {user.name} has {len(items)} items"
log_entry = f"Processing {batch_size} items at {datetime.now()}"
query = f"SELECT * FROM users WHERE id = {user_id} AND active = true"

# ❌ ERRADO
message = "User {} has {} items".format(user.name, len(items))
message = "User %s has %d items" % (user.name, len(items))
```

## **Imports e Paths**

### **📂 Pathlib vs os.path**
- Prefira **`pathlib.Path`** em vez de `os.path`.
- Pathlib é mais moderno, legível e cross-platform.

#### **Exemplo:**
```python
# ✅ CORRETO
from pathlib import Path

config_file = Path("config") / "settings.yaml"
if config_file.exists():
    content = config_file.read_text(encoding="utf-8")

# ❌ ERRADO
import os.path

config_file = os.path.join("config", "settings.yaml")
if os.path.exists(config_file):
    with open(config_file, encoding="utf-8") as f:
        content = f.read()
```

### **📚 Organização de Imports**
- **Ordene imports** em três grupos (com linhas em branco entre grupos):
  1. **Standard library** (built-in)
  2. **Third-party** (pip/uv installed)
  3. **Local** (seu projeto)

#### **Exemplo:**
```python
# Standard library
import json
import logging
from datetime import datetime
from pathlib import Path

# Third-party
import requests
from pydantic import BaseModel
from sqlalchemy import create_engine

# Local
from core.config import settings
from modules.user import UserService
from utils.helpers import format_currency
```

## **Queries e Strings Longas**

### **📄 Queries SQL em Múltiplas Linhas**
- **Quebre queries longas** (SQL, PromQL etc.) em múltiplas linhas.
- Use triple quotes para queries complexas.

#### **Exemplo:**
```python
# ✅ CORRETO
query = """
    SELECT
        u.id,
        u.name,
        u.email,
        p.title as profile_title
    FROM users u
    LEFT JOIN profiles p ON u.id = p.user_id
    WHERE u.is_active = %(is_active)s
        AND u.created_at >= %(start_date)s
    ORDER BY u.created_at DESC
    LIMIT %(limit)s
"""

# ❌ ERRADO
query = "SELECT u.id, u.name, u.email, p.title as profile_title FROM users u LEFT JOIN profiles p ON u.id = p.user_id WHERE u.is_active = %(is_active)s AND u.created_at >= %(start_date)s ORDER BY u.created_at DESC LIMIT %(limit)s"
```

## **Documentação**

### **📖 Docstrings Obrigatórias**
- **Docstrings obrigatórias** em nível de:
  - **Módulos** (topo do arquivo)
  - **Classes** (logo após `class`)
  - **Funções públicas** (logo após `def`)
- Sejam **compactas**, **em inglês** e **≤ 80 colunas**.
- **Quebre linhas quando necessário**.

#### **Exemplo:**
```python
"""User management module.

This module provides functionality for user authentication,
profile management, and user-related business logic.
"""

class UserService:
    """Service for user-related operations.

    Handles user creation, authentication, profile updates,
    and user data validation.
    """

    def authenticate_user(
        self,
        email: str,
        password: str,
    ) -> User | None:
        """Authenticate user with email and password.

        Args:
            email: User email address
            password: Plain text password

        Returns:
            User object if authentication successful, None otherwise

        Raises:
            ValidationError: If email format is invalid
        """
        ...
```

## **Configuração e Constantes**

### **🔧 Evitar Valores Mágicos**
- **Evite valores mágicos**; prefira **variáveis de ambiente** ou arquivos de configuração.
- Use constantes nomeadas para valores fixos.

#### **Exemplo:**
```python
# ✅ CORRETO
import os
from pathlib import Path

# Constants
MAX_RETRY_ATTEMPTS = 3
DEFAULT_TIMEOUT_SECONDS = 30
API_BASE_URL = os.getenv("API_BASE_URL", "https://api.example.com")

# Configuration
CONFIG_FILE = Path("config") / "app.yaml"

def fetch_data(url: str) -> dict[str, Any]:
    for attempt in range(MAX_RETRY_ATTEMPTS):
        response = requests.get(
            url,
            timeout=DEFAULT_TIMEOUT_SECONDS,
        )
        if response.status_code == 200:
            return response.json()

# ❌ ERRADO
def fetch_data(url: str) -> dict[str, Any]:
    for attempt in range(3):  # Valor mágico
        response = requests.get(url, timeout=30)  # Valor mágico
        if response.status_code == 200:  # OK, mas poderia ser HTTP_OK
            return response.json()
```

## **Integração com Outros Guidelines**

### **🎯 Ordem de Aplicação**
1. **Princípios gerais** → Filosofia universal de desenvolvimento
2. **Zen of Python** → Filosofia específica Python + templates práticos
3. **Estas regras Python** → Implementação técnica específica
4. **Bibliotecas preferidas** → Escolhas de bibliotecas e ferramentas
5. **Ruff/PEP 8** → Formatação automática