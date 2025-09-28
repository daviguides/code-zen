# Plano Detalhado de Reestruturação: python-guideline → code-zen

## Contexto
- **Diretório atual:** `/Users/daviguides/work/sources/my/code_assistant/code-zen` (já renomeado)
- **Objetivo:** Criar estrutura `zen-code-standards/` com reorganização por linguagem

---

## Estrutura Final Desejada

```
code-zen/                                    # Repo root (já renomeado ✓)
├── README.md                                # CRIAR
├── LICENSE                                  # CRIAR
├── install.sh                               # CRIAR
├── claude-plug-in-sample.md                # ATUALIZAR
└── zen-code-standards/                      # CRIAR diretório
    ├── coding-standards.md                  # MOVER + ATUALIZAR
    ├── universal/                           # CRIAR + MOVER arquivos
    │   ├── general_coding_principles.md
    │   └── project_setup_guidelines.md
    ├── python/                              # CRIAR + MOVER arquivos
    │   ├── python_quick_reference.md
    │   ├── python_library_preferences.md
    │   ├── python_specific_rules.md
    │   ├── tdd_guidelines.md
    │   ├── tdd_optimized_guidelines.md
    │   └── zen_of_python/                   # MOVER diretório inteiro
    │       ├── zen_quick_reference.md
    │       ├── zen_guideline_llm.md
    │       └── zen_theory_explained.md
    └── other_rules/                         # MOVER diretório
        └── file-references-guideline.md
```

---

## Passos Detalhados para Execução

### **FASE 1: Criar Nova Estrutura**

```bash
# 1.1 Criar diretório principal
mkdir -p zen-code-standards

# 1.2 Criar subdiretórios
mkdir -p zen-code-standards/universal
mkdir -p zen-code-standards/python
mkdir -p zen-code-standards/python/zen_of_python
mkdir -p zen-code-standards/other_rules
```

---

### **FASE 2: Mover Arquivos para Universal**

```bash
# 2.1 Mover arquivos universais
mv coding-standards/my_coding_rules/general_coding_principles.md zen-code-standards/universal/
mv coding-standards/my_coding_rules/project_setup_guidelines.md zen-code-standards/universal/
```

---

### **FASE 3: Mover Arquivos Python-Específicos**

```bash
# 3.1 Mover arquivos Python
mv coding-standards/my_coding_rules/python_quick_reference.md zen-code-standards/python/
mv coding-standards/my_coding_rules/python_library_preferences.md zen-code-standards/python/
mv coding-standards/my_coding_rules/python_specific_rules.md zen-code-standards/python/
mv coding-standards/my_coding_rules/tdd_guidelines.md zen-code-standards/python/
mv coding-standards/my_coding_rules/tdd_optimized_guidelines.md zen-code-standards/python/

# 3.2 Remover arquivo duplicado se existir
rm -f "coding-standards/my_coding_rules/tdd_guidelines copy.md"

# 3.3 Mover diretório zen_of_python inteiro
mv coding-standards/zen_of_python zen-code-standards/python/
```

---

### **FASE 4: Mover Outros Arquivos**

```bash
# 4.1 Mover other_rules
mv coding-standards/other_rules zen-code-standards/

# 4.2 Mover coding-standards.md
mv coding-standards/coding-standards.md zen-code-standards/
```

---

### **FASE 5: Limpar Estrutura Antiga**

```bash
# 5.1 Remover diretórios vazios antigos
rmdir coding-standards/my_coding_rules 2>/dev/null || true
rmdir coding-standards 2>/dev/null || true

# 5.2 Remover projeto de teste
rm -rf text-analyzer_test-project

# 5.3 Remover arquivos temporários
rm -f .DS_Store
```

---

### **FASE 6: Atualizar Referências em Arquivos**

#### **6.1 Atualizar `zen-code-standards/coding-standards.md`**

```markdown
# Coding Standards, Rules and Code Guidelines

**Essential files to read immediately below:**

- Universal Setup: @./universal/project_setup_guidelines.md
- Universal Principles: @./universal/general_coding_principles.md

**Python-specific:**
- @./python/python_quick_reference.md
- @./python/python_library_preferences.md
- @./python/tdd_optimized_guidelines.md
- @./python/zen_of_python/zen_quick_reference.md
- @./python/zen_of_python/zen_guideline_llm.md

**Optional detailed guidance:**

- Traditional TDD: `./python/tdd_guidelines.md`
- Full Technical Rules: `./python/python_specific_rules.md`
- Zen Theory: `./python/zen_of_python/zen_theory_explained.md`

## **📋 Meta Guidelines**

### **📎 Para regras de referências de arquivos:**
→ `@./other_rules/file-references-guideline.md`
```

#### **6.2 Atualizar `claude-plug-in-sample.md`**

```markdown
Python project that scans a folder of text files, analyzes their content, and generates a summary report in JSON format.

# Project Coding Standards

## Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply

## Project Overrides
<!-- Add project-specific overrides here when needed -->
*No overrides currently defined - using all universal standards*
```

---

### **FASE 7: Criar Novos Arquivos**

#### **7.1 Criar `README.md`**

```markdown
# Code Zen

> Philosophy-driven coding standards for multiple languages, designed as a Claude Code plugin.

## What is Code Zen?

Code Zen is a collection of **language-agnostic** and **language-specific** coding guidelines that help you write clear, maintainable code following zen-like principles:

- **Clarity over cleverness**
- **Readability first**
- **Single responsibility**
- **Explicit over implicit**

## Quick Start

### Installation

```bash
git clone https://github.com/your-username/code-zen.git
cd code-zen
chmod +x install.sh
./install.sh
```

The installer will:
1. Copy `zen-code-standards/` to `~/.claude/zen-code-standards/`
2. Optionally configure `~/.claude/CLAUDE.md`

### Manual Installation

If you prefer manual setup:

```bash
# Copy standards
cp -r zen-code-standards ~/.claude/

# Add to ~/.claude/CLAUDE.md
cat >> ~/.claude/CLAUDE.md << 'EOF'

# Project Coding Standards

## Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply
EOF
```

## Usage

Once installed globally, reference Code Zen in any project's `CLAUDE.md`:

```markdown
# Project Coding Standards

## Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply

## Project Overrides
<!-- Add project-specific overrides here -->
```

See [claude-plug-in-sample.md](./claude-plug-in-sample.md) for detailed examples.

## Structure

```
zen-code-standards/
├── coding-standards.md       # Entry point
├── universal/                # Language-agnostic principles
│   ├── general_coding_principles.md
│   └── project_setup_guidelines.md
├── python/                   # Python-specific guidelines
│   ├── python_quick_reference.md
│   ├── python_library_preferences.md
│   ├── tdd_optimized_guidelines.md
│   └── zen_of_python/
│       ├── zen_quick_reference.md
│       ├── zen_guideline_llm.md
│       └── zen_theory_explained.md
└── other_rules/
    └── file-references-guideline.md
```

## Supported Languages

- ✅ **Python** - Complete guidelines including Zen of Python
- 🚧 **Rust** - Coming soon
- 🚧 **Go** - Coming soon

## Philosophy

Code Zen is built on timeless principles:

### Universal Principles
- Write code in English
- Prioritize clarity and readability
- Single Responsibility Principle
- Avoid magic numbers/strings
- Errors should never pass silently

### Python Zen
- Beautiful is better than ugly
- Explicit is better than implicit
- Simple is better than complex
- Readability counts

See [universal/general_coding_principles.md](./zen-code-standards/universal/general_coding_principles.md) for complete guidelines.

## Contributing

Contributions welcome! To add support for a new language:

1. Create `zen-code-standards/<language>/` directory
2. Add language-specific guidelines
3. Update `coding-standards.md` to reference new language
4. Submit PR

## License

MIT License - See [LICENSE](./LICENSE) for details

## Author

Philosophy-driven code standards for Claude Code
```

#### **7.2 Criar `install.sh`**

```bash
#!/bin/bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CLAUDE_DIR="$HOME/.claude"
TARGET_DIR="$CLAUDE_DIR/zen-code-standards"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"

echo -e "${BLUE}Code Zen Installer${NC}"
echo -e "${BLUE}==================${NC}\n"

# Check if ~/.claude exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${YELLOW}Creating ~/.claude directory...${NC}"
    mkdir -p "$CLAUDE_DIR"
fi

# Copy zen-code-standards folder
echo -e "${BLUE}Installing zen-code-standards to $TARGET_DIR...${NC}"
if [ -d "$TARGET_DIR" ]; then
    read -p "Directory $TARGET_DIR already exists. Overwrite? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$TARGET_DIR"
    else
        echo -e "${YELLOW}Installation cancelled.${NC}"
        exit 0
    fi
fi

cp -r zen-code-standards "$TARGET_DIR"
echo -e "${GREEN}✓ zen-code-standards installed successfully!${NC}\n"

# Handle CLAUDE.md configuration
SAMPLE_CONFIG="# Project Coding Standards

## Standards Inheritance
- **INHERITS FROM**: @./zen-code-standards/coding-standards.md
- **PRECEDENCE**: Project-specific rules override universal standards
- **FALLBACK**: When no override exists, universal standards apply

## Project Overrides
<!-- Add project-specific overrides here when needed -->
*No overrides currently defined - using all universal standards*"

if [ ! -f "$CLAUDE_MD" ]; then
    echo -e "${BLUE}No CLAUDE.md found in ~/.claude/${NC}"
    read -p "Create ~/.claude/CLAUDE.md with Code Zen configuration? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "$SAMPLE_CONFIG" > "$CLAUDE_MD"
        echo -e "${GREEN}✓ CLAUDE.md created successfully!${NC}\n"
    else
        echo -e "${YELLOW}Skipped CLAUDE.md creation.${NC}"
        echo -e "${YELLOW}To use Code Zen, add this to your ~/.claude/CLAUDE.md:${NC}\n"
        echo "$SAMPLE_CONFIG"
        echo
    fi
else
    echo -e "${YELLOW}~/.claude/CLAUDE.md already exists.${NC}"
    read -p "Append Code Zen configuration to existing CLAUDE.md? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Check if already configured
        if grep -q "zen-code-standards" "$CLAUDE_MD"; then
            echo -e "${YELLOW}Code Zen already configured in CLAUDE.md${NC}"
        else
            echo -e "\n\n$SAMPLE_CONFIG" >> "$CLAUDE_MD"
            echo -e "${GREEN}✓ Code Zen configuration added to CLAUDE.md${NC}\n"
        fi
    else
        echo -e "${YELLOW}Skipped CLAUDE.md modification.${NC}"
        echo -e "${YELLOW}To use Code Zen, add this to your ~/.claude/CLAUDE.md:${NC}\n"
        echo "$SAMPLE_CONFIG"
        echo
    fi
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "\n${BLUE}Next steps:${NC}"
echo "1. Check ~/.claude/CLAUDE.md to ensure configuration is correct"
echo "2. Use Code Zen in any project by referencing it in project CLAUDE.md"
echo "3. See claude-plug-in-sample.md for usage examples"
echo -e "\n${BLUE}Documentation:${NC} https://github.com/your-repo/code-zen"
```

#### **7.3 Criar `LICENSE`**

```text
MIT License

Copyright (c) 2025 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

### **FASE 8: Tornar install.sh Executável**

```bash
chmod +x install.sh
```

---

### **FASE 9: Verificação Final**

```bash
# 9.1 Verificar estrutura criada
tree zen-code-standards -L 3

# 9.2 Verificar que arquivos antigos foram removidos
ls -la coding-standards/ 2>/dev/null && echo "ERRO: coding-standards ainda existe" || echo "✓ coding-standards removido"
ls -la text-analyzer_test-project/ 2>/dev/null && echo "ERRO: text-analyzer ainda existe" || echo "✓ text-analyzer removido"

# 9.3 Listar arquivos na raiz
ls -la
```

---

## Resumo de Comandos (Ordem de Execução)

```bash
# Copie e cole este bloco completo na sessão nova:

cd /Users/daviguides/work/sources/my/code_assistant/code-zen

# FASE 1: Criar estrutura
mkdir -p zen-code-standards/{universal,python/zen_of_python,other_rules}

# FASE 2-4: Mover arquivos
mv coding-standards/my_coding_rules/general_coding_principles.md zen-code-standards/universal/
mv coding-standards/my_coding_rules/project_setup_guidelines.md zen-code-standards/universal/
mv coding-standards/my_coding_rules/python_*.md zen-code-standards/python/
mv coding-standards/my_coding_rules/tdd_*.md zen-code-standards/python/
rm -f "coding-standards/my_coding_rules/tdd_guidelines copy.md"
mv coding-standards/zen_of_python zen-code-standards/python/
mv coding-standards/other_rules zen-code-standards/
mv coding-standards/coding-standards.md zen-code-standards/

# FASE 5: Limpar
rmdir coding-standards/my_coding_rules coding-standards 2>/dev/null || true
rm -rf text-analyzer_test-project .DS_Store

# FASE 6-7: Criar novos arquivos (usar comandos Write/Edit do Claude)
# - Atualizar zen-code-standards/coding-standards.md
# - Atualizar claude-plug-in-sample.md
# - Criar README.md
# - Criar install.sh
# - Criar LICENSE

# FASE 8: Permissões
chmod +x install.sh

# FASE 9: Verificar
tree zen-code-standards -L 3 || find zen-code-standards -type f
```

---

## Checklist Final

- [ ] Estrutura `zen-code-standards/` criada
- [ ] Arquivos movidos para `universal/`
- [ ] Arquivos movidos para `python/`
- [ ] `zen_of_python/` movido inteiro
- [ ] `other_rules/` movido
- [ ] Diretórios antigos removidos
- [ ] `coding-standards.md` atualizado com novos paths
- [ ] `claude-plug-in-sample.md` atualizado
- [ ] `README.md` criado
- [ ] `install.sh` criado e executável
- [ ] `LICENSE` criado
- [ ] Projeto de teste removido
- [ ] Arquivos temporários removidos

---

**Importante:** Execute na ordem, verifique cada fase antes de continuar para próxima!
