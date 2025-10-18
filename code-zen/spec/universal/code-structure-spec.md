# Universal Code Structure Specification

## Fundamental Principles

### Single Responsibility Principle (SRP)
- **Each function/method must have ONE responsibility**
- If a function does multiple things, extract subfunctions
- **Classes must have ONE reason to change**

### DRY (Don't Repeat Yourself)
- **Avoid logic duplication**
- Extract common code into reusable functions/modules
- **One source of truth** for each concept

### KISS (Keep It Simple, Stupid)
- **Prefer simple solutions** over complex ones
- **Complexity must be justified** by real necessity
- **Avoid over-engineering** for uncertain future requirements

### YAGNI (You Aren't Gonna Need It)
- **Implement only what is needed now**
- Don't add features "just in case"
- **Refactor when the need arises**

## Code Organization

### Modular Structuring by Context
- Structure modules/files by **business context** or **domain**
- If a module grows too large or contains multiple actions, **divide into subcontexts**
- **High cohesion within modules, low coupling between modules**

### Narrative Organization (Top-Down Flow)
- In each module/file, **define the main function first**
- Main function should **act as index/roadmap** (orchestration)
- Should **call helpers** and contain **minimal logic**
- **Order helper/auxiliary functions** in the sequence they are called
- Create **natural narrative flow**: index → chapter → subtitle

**Conceptual flow:**
```
main_function()          # Orchestration - "what"
  ├─ step_1()            # First step
  ├─ step_2()            # Second step
  └─ step_3()            # Third step
      ├─ substep_3a()    # Step 3 details
      └─ substep_3b()    # More details
```

## Project Architecture

### Main Entry Point
- Always include **clear main entry point**:
  - `main.py` (Python)
  - `index.js` (Node.js)
  - `main.go` (Go)
  - `Program.cs` (C#)

### Multiple Cohesive Modules
- **Organize code in multiple cohesive files/modules**
- Avoid excessive accumulation in a single file
- **Divide by responsibilities**, not by technical types

### Extensible Architecture
- Structure project to be **easy to extend in the future**
- Allow adding new functionality without **significant breaking changes**
- **Design for change** - anticipate that requirements will change

## Language Universality

### English Only
- Write **all code in English**:
  - Variable names
  - Function names
  - Class names
  - Comments
  - Error messages
- **Rationale:** Facilitates international collaboration and maintenance

### Clarity and Readability
- Maintain **clarity, readability, and single responsibility** in each function/method
- **Prioritize clarity over cleverness**
- **Code is read more times than it is written** - optimize for reading
