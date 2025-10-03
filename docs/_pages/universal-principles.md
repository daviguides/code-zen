---
layout: page
title: Universal Principles
---

## Language-Agnostic Coding Standards

These principles apply to **any programming language** and form the foundation of Code Zen philosophy.

---

## **Fundamental Principles**

### **🌐 Universal Language**
- Write **all code in English** (variable names, functions, classes, comments, error messages)
- **Rationale:** Facilitates international collaboration and maintenance by different developers

### **📖 Clarity and Readability**
- Maintain **clarity, readability, and single responsibility** in every function/method
- **Prioritize clarity over cleverness** - code should tell a clear story
- **Code is read more often than written** - optimize for reading

### **🎯 Single Responsibility Principle**
- **Each function/method should have a single responsibility**
- If a function does more than one thing, **extract sub-functions** and call them
- **Classes should have a single reason to change**

---

## **Code Organization**

### **📚 Modular Structure by Context**
- Structure modules/files by **business context** or **domain**
- If a module grows too large or contains multiple actions, **divide into sub-contexts**
- **High cohesion within modules, low coupling between modules**

### **🎼 Narrative Organization (Top-Down Flow)**
- In each module/file, **define the main function first**
  - This function should **act as an index/roadmap** (orchestration)
  - Should **call helpers** and contain **minimal logic**
- **Order helper/auxiliary functions** in the sequence they are called
- Create a **natural narrative flow**: index → chapter → subtitle

#### **Conceptual Example:**
```
main_function()          # Orchestration - "what"
  ├─ step_1()            # First step
  ├─ step_2()            # Second step
  └─ step_3()            # Third step
      ├─ substep_3a()    # Details of third step
      └─ substep_3b()    # More details
```

---

## **Project Architecture**

### **🚪 Main Entry Point**
- Always include a **clear main entry point**:
  - `main.py` (Python)
  - `index.js` (Node.js)
  - `main.go` (Go)
  - `Program.cs` (C#)
  - etc.

### **🏗️ Multiple Cohesive Modules**
- **Organize code into multiple files/modules** cohesively
- Avoid excessive accumulation in a single file
- **Divide by responsibilities**, not by technical types

### **🔮 Extensible Architecture**
- Structure the project to be **easy to extend in the future**
- Allow adding new features without causing **significant breaks**
- **Design for change** - anticipate that requirements will change

---

## **Code Quality**

### **🔢 Avoid Magic Values**
- **Never use "magic" numbers/strings** directly in code
- Prefer **named constants** or **configuration files**
- **Make intentions explicit** through descriptive names

#### **Example:**
```javascript
// ❌ MAGIC VALUE
if (attempts > 3) { ... }

// ✅ NAMED CONSTANT
const MAX_RETRY_ATTEMPTS = 3;
if (attempts > MAX_RETRY_ATTEMPTS) { ... }
```

### **💬 Strategic Comments**
- **Targeted comments** are allowed when necessary
- Always **in English** and well-formatted
- **Explain the "why", not the "what"**
- Prefer **self-documenting code** over excessive comments

### **📏 Consistent Formatting**
- Use **automatic formatting tools** for the language:
  - **Prettier** (JavaScript/TypeScript)
  - **Black/Ruff** (Python)
  - **gofmt** (Go)
  - **rustfmt** (Rust)
- Maintain **reasonable line limits** (80-100 characters)

---

## **Error Handling**

### **🚨 Explicit Errors**
- **Errors should never pass silently**
- Make **failures obvious** so they can be fixed
- Use the language's **exception/error system** appropriately

### **📝 Context in Errors**
- **Include sufficient context** in error messages
- Facilitate **debugging** with relevant information
- **Log errors** with appropriate severity

---

## **Design Principles**

### **🔄 DRY (Don't Repeat Yourself)**
- **Avoid logic duplication**
- Extract common code into **reusable functions/modules**
- **One source of truth** for each concept

### **💎 KISS (Keep It Simple, Stupid)**
- **Prefer simple solutions** over complex ones
- **Complexity must be justified** by real necessity
- **Avoid over-engineering** for uncertain future requirements

### **📐 YAGNI (You Aren't Gonna Need It)**
- **Implement only what is needed now**
- Don't add features "just in case"
- **Refactor when the need arises**

---

## **Documentation and Versioning**

### **📚 Essential Documentation**
- **README** with setup and usage instructions
- **API documentation** for public interfaces
- **Code comments** when logic is complex

### **🔧 Explicit Configuration**
- **Externalize configurations** (environment variables, config files)
- **Don't hardcode** environment-specific values
- **Document** all necessary configurations

---

## **Universal Application**

These principles apply to **any programming language** and should be followed regardless of the technology chosen.

### **Application Hierarchy:**
1. **General principles** (this document) - fundamental philosophy
2. **Language-specific rules** - technical implementation
3. **Libraries and tools** - specific choices
4. **Formatting tools** - automated style

---

## **Key Takeaways**

- **Clarity over cleverness** - Always prioritize understandable code
- **Single responsibility** - Each component does one thing well
- **Explicit over implicit** - Make intentions obvious
- **Design for change** - Anticipate evolution
- **Fail loudly** - Errors should be visible and actionable

These universal principles form the foundation that language-specific guidelines build upon.
