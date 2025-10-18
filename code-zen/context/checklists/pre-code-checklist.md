# Pre-Code Implementation Checklist

## BEFORE Writing Any Code - MANDATORY Checks

### 🔍 Group 1: Foundations (CRITICAL)

**Beautiful - Code Aesthetics:**
- [ ] Will this code follow PEP 8 conventions?
- [ ] Are names consistent with project patterns?
- [ ] Will the structure be clean and organized?

**Explicit - Clear Intentions:**
- [ ] Will all code intentions be clear?
- [ ] Are there any "magic" or implicit behaviors?
- [ ] Can someone understand without special knowledge?

**Readability - Human-First:**
- [ ] Can a junior developer understand this code?
- [ ] Does the code tell a clear story?
- [ ] Am I avoiding unnecessary cleverness?

### 🏗️ Group 2: Structure (CRITICAL)

**Simple vs Complex:**
- [ ] Am I using the simplest solution for this problem?
- [ ] If complex, is it because the problem is inherently complex?
- [ ] Am I avoiding over-engineering?

**Flat - Avoid Nesting:**
- [ ] Are there unnecessary nesting levels?
- [ ] Can I use guard clauses or early returns?
- [ ] Is the control flow linear and clear?

**Sparse - Proper Spacing:**
- [ ] Does the code have adequate spacing?
- [ ] Am I avoiding dense or compressed lines?
- [ ] Should I break complex expressions into multiple lines?

### ⚖️ Group 3: Decisions (WHEN APPLICABLE)

**Special Cases:**
- [ ] Am I maintaining consistency even in edge cases?
- [ ] Am I avoiding unique solutions for "special" cases?
- [ ] Am I following established patterns?

**Practicality vs Purity:**
- [ ] If breaking a convention, is there clear practical benefit?
- [ ] Have I documented the reason for the exception?
- [ ] Does the benefit justify the deviation?

**Ambiguity:**
- [ ] Am I avoiding assumptions about inputs or behavior?
- [ ] Am I forcing clarity where there is ambiguity?
- [ ] Have I documented necessary assumptions?

**One Obvious Way:**
- [ ] Is there a more "Pythonic" way to do this?
- [ ] Am I following established language conventions?
- [ ] Am I avoiding reinventing the wheel?

## Quick Verification Questions

### For Functions
- **"Can I explain what this function does in one sentence?"**
  - If NO → refactor or divide the function

- **"Does this function have hidden side effects?"**
  - If YES → make them explicit or extract to separate function

- **"Are input validations clear and complete?"**
  - If NO → add explicit validation at function start

### For Classes
- **"Does this class have a single clear responsibility?"**
  - If NO → consider dividing into smaller classes

- **"Is the public interface intuitive and explicit?"**
  - If NO → review method names and signatures

- **"Is internal state managed clearly?"**
  - If NO → add validation in constructor and methods

### For Modules
- **"Do all functions/classes in this module belong to the same context?"**
  - If NO → consider dividing the module

- **"Are imports organized and explicit?"**
  - If NO → organize into groups (stdlib, third-party, local)

- **"Is the module less than 500 lines?"**
  - If NO → consider splitting by responsibilities

## Red Flags - STOP If Found

- 🚨 **"This is too clever"** → Violates Simple > Complex
- 🚨 **"Only works if you know X"** → Violates Explicit > Implicit
- 🚨 **"5+ levels of if/for"** → Violates Flat > Nested
- 🚨 **"Line 120+ characters"** → Violates Sparse > Dense (80 max!)
- 🚨 **"Can't explain how it works"** → Violates "Hard to explain = bad idea"
- 🚨 **"Using default values with 'or'"** → Implicit behavior
- 🚨 **"Bare except:"** → Silent errors

## Conflict Resolution Hierarchy

When Zen principles conflict, use this order:

1. **Readability ALWAYS wins** - Never sacrifice legibility
2. **Explicit > Implicit** - When there's ambiguity
3. **Simple > Complex** - For simple problems
4. **Practicality > Purity** - With clear documented benefit
5. **Consistency > Cleverness** - In special cases

## Context-Specific Considerations

### Writing Functions
- **Primary Principles**: Readability, Simple > Complex
- **Verification**: "Can I explain in one sentence?"

### Structuring Classes
- **Primary Principles**: Explicit > Implicit, Single Responsibility
- **Verification**: "One clear responsibility?"

### Organizing Modules
- **Primary Principles**: Namespaces, One obvious way
- **Verification**: "Are imports clear?"

### Error Handling
- **Primary Principles**: Errors never silent, Unless silenced
- **Verification**: "Is failure obvious?"

### Refactoring
- **Primary Principles**: Readability, Flat > Nested
- **Verification**: "Did clarity improve?"

## Final Checklist Before Proceeding

Only proceed with implementation if ALL items below are TRUE:

- ✅ I understand what needs to be built
- ✅ I've identified the implementation context (function/class/module/etc.)
- ✅ I know which Zen principles are most important for this context
- ✅ I've reviewed relevant templates and patterns
- ✅ I have a plan to avoid common anti-patterns
- ✅ I can explain the approach in simple terms
- ✅ The solution will be explicit and readable
- ✅ No red flags have been detected

**If ANY item is ❌ → Stop and reconsider before writing code**
