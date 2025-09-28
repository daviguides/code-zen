# General Coding Principles - Regras Universais de Desenvolvimento

## **Princípios Fundamentais**

### **🌐 Linguagem Universal**
- Escreva **todo o código em inglês** (nomes de variáveis, funções, classes, comentários, mensagens de erro).
- **Rationale:** Facilita colaboração internacional e manutenção por diferentes desenvolvedores.

### **📖 Clareza e Legibilidade**
- Mantenha **clareza, legibilidade e responsabilidade única** em cada função/método.
- **Priorize clareza sobre cleverness** - código deve contar uma história clara.
- **Código é lido mais vezes do que é escrito** - otimize para leitura.

### **🎯 Single Responsibility Principle**
- **Cada função/método deve ter uma única responsabilidade**.
- Se uma função faz mais de uma coisa, **extraia subfunções** e chame-as.
- **Classes devem ter uma única razão para mudar**.

## **Organização de Código**

### **📚 Estruturação Modular por Contexto**
- Estruture módulos/arquivos por **contexto de negócio** ou **domínio**.
- Se um módulo cresce demais ou contém múltiplas ações, **divida em subcontextos**.
- **Coesão alta dentro do módulo, acoplamento baixo entre módulos**.

### **🎼 Organização Narrativa (Fluxo Top-Down)**
- Em cada módulo/arquivo, **defina a função principal primeiro**.
  - Essa função deve **agir como índice/roteiro** (orquestração).
  - Deve **chamar helpers** e conter **o mínimo de lógica**.
- **Ordene helpers/funções auxiliares** na sequência em que são chamados.
- Crie um **fluxo narrativo natural**: índice → capítulo → subtítulo.

#### **Exemplo conceitual:**
```
main_function()          # Orquestração - "what"
  ├─ step_1()            # Primeiro passo
  ├─ step_2()            # Segundo passo
  └─ step_3()            # Terceiro passo
      ├─ substep_3a()    # Detalhes do terceiro passo
      └─ substep_3b()    # Mais detalhes
```

## **Arquitetura de Projeto**

### **🚪 Ponto de Entrada Principal**
- Inclua sempre um **ponto de entrada principal** claro:
  - `main.py` (Python)
  - `index.js` (Node.js)
  - `main.go` (Go)
  - `Program.cs` (C#)
  - etc.

### **🏗️ Múltiplos Módulos Coesos**
- **Organize o código em múltiplos arquivos/módulos** de forma coesa.
- Evite acúmulo excessivo em um único arquivo.
- **Divida por responsabilidades**, não por tipos técnicos.

### **🔮 Arquitetura Extensível**
- Estruture o projeto para ser **fácil de estender no futuro**.
- Permita adicionar novas funcionalidades sem causar **quebras significativas**.
- **Design for change** - antecipe que requisitos vão mudar.

## **Qualidade de Código**

### **🔢 Evitar Valores Mágicos**
- **Nunca use números/strings "mágicos"** diretamente no código.
- Prefira **constantes nomeadas** ou **arquivos de configuração**.
- **Torne intenções explícitas** através de nomes descritivos.

#### **Exemplo conceitual:**
```
// ❌ VALOR MÁGICO
if (attempts > 3) { ... }

// ✅ CONSTANTE NOMEADA
const MAX_RETRY_ATTEMPTS = 3;
if (attempts > MAX_RETRY_ATTEMPTS) { ... }
```

### **💬 Comentários Estratégicos**
- **Comentários pontuais** são permitidos quando necessários.
- Sempre **em inglês** e bem formatados.
- **Explique o "por quê", não o "o quê"**.
- Prefira **código autoexplicativo** a comentários excessivos.

### **📏 Formatação Consistente**
- Use **ferramentas de formatação automática** da linguagem:
  - **Prettier** (JavaScript/TypeScript)
  - **Black/Ruff** (Python)
  - **gofmt** (Go)
  - **rustfmt** (Rust)
- Mantenha **limites de linha** razoáveis (80-100 caracteres).

## **Tratamento de Erros**

### **🚨 Erros Explícitos**
- **Erros nunca devem passar silenciosamente**.
- Torne **falhas óbvias** para que possam ser corrigidas.
- Use o **sistema de exceções/erros** da linguagem apropriadamente.

### **📝 Contexto nos Erros**
- **Inclua contexto suficiente** nas mensagens de erro.
- Facilite **debugging** com informações relevantes.
- **Log erros** com severidade apropriada.

## **Princípios de Design**

### **🔄 DRY (Don't Repeat Yourself)**
- **Evite duplicação de lógica**.
- Extraia código comum em **funções/módulos reutilizáveis**.
- **Uma fonte de verdade** para cada conceito.

### **💎 KISS (Keep It Simple, Stupid)**
- **Prefira soluções simples** a soluções complexas.
- **Complexidade deve ser justificada** pela necessidade real.
- **Evite over-engineering** para requisitos futuros incertos.

### **📐 YAGNI (You Aren't Gonna Need It)**
- **Implemente apenas o que é necessário agora**.
- Não adicione funcionalidades "por precaução".
- **Refatore quando a necessidade surgir**.

## **Versionamento e Documentação**

### **📚 Documentação Essencial**
- **README** com instruções de setup e uso.
- **Documentação de API** para interfaces públicas.
- **Comentários de código** quando a lógica é complexa.

### **🔧 Configuração Explícita**
- **Externalize configurações** (environment variables, config files).
- **Não hardcode** valores específicos de ambiente.
- **Documente** todas as configurações necessárias.

## **Aplicação Universal**

Estes princípios se aplicam a **qualquer linguagem de programação** e devem ser seguidos independentemente da tecnologia escolhida.

### **Hierarquia de Aplicação:**
1. **Princípios gerais** (este documento) - filosofia fundamental
2. **Regras específicas da linguagem** - implementação técnica
3. **Bibliotecas e ferramentas** - escolhas específicas
4. **Ferramentas de formatação** - estilo automatizado