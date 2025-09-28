# Project Setup Guidelines

## Setup de um novo projeto Python

Para fazer um setup de um novo projeto Python rode:

### **Step 1: Initialize Project**
```bash
uv init
```

### **Step 2: Get Project Path**
```bash
pwd
```

Pegue os nomes dos diretórios após `/Users/daviguides/work/sources/`

**Exemplo:**
- Se o path for: `/Users/daviguides/work/sources/my/folder_a/folder-b`
- Pegue: `my folder_a folder-b`

### **Step 3: Run Sourcerer Setup**
```bash
sourcerer my folder_a folder-b
```

## Project Structure Result

Após o setup, você terá uma estrutura padrão:

```
project_name/
├── main.py                    # Entry point
├── project_name/              # Main package
├── tests/                     # Test directory
├── pyproject.toml            # Dependencies and config
├── README.md                 # Project documentation
└── .gitignore               # Git ignore rules
```
