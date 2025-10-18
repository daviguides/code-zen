# Zen Code Refactoring Workflow

Refactor code following Zen of Python principles and best practices.

## Code Zen Standards Context

Antes de qualquer passo faça:
- Execute o command /code-zen:load-universal-context
- Execute o command /code-zen:load-zen-context
- Execute o command /code-zen:load-python-context

---

## Zen Principles for Refactoring

Focus on:
- **Readability counts** - Make code more readable
- **Flat > Nested** - Reduce nesting levels
- **Simple > Complex** - Simplify unnecessary complexity
- **Explicit > Implicit** - Make intentions clear
- **Beautiful > Ugly** - Improve structure and formatting

## Refactoring Process

### Step 1: Identify Problems

**Analyze current code for:**
- Deep nesting (> 3 levels)
- Unclear/cryptic names
- Magic numbers/strings
- Implicit behavior
- Missing type hints
- Missing docstrings
- Silent error handling
- Overly complex logic
- Violations of single responsibility

### Step 2: Plan Improvements

**For each problem, determine fix:**
- **Deep nesting** → Apply guard clauses
- **Unclear names** → Rename for clarity
- **Magic numbers** → Extract as named constants
- **Implicit behavior** → Make explicit
- **Missing type hints** → Add Python 3.13+ hints
- **Missing docstrings** → Add with Args/Returns/Raises
- **Silent errors** → Add explicit error handling
- **Complex logic** → Break into smaller functions
- **Multiple responsibilities** → Extract into separate functions

### Step 3: Apply Zen-Compliant Fixes

**Refactoring Checklist:**
- [ ] Names more descriptive than before
- [ ] Logic clearer and more explicit
- [ ] Nesting reduced (guard clauses used)
- [ ] Responsibilities separated
- [ ] Type hints added
- [ ] Validation made explicit
- [ ] Main function is orchestration
- [ ] Magic numbers extracted as constants
- [ ] Error handling explicit and specific
- [ ] Docstrings added/improved

### Step 4: Verify Improvements

**Ensure:**
- Code is clearer than before
- Unnecessary complexity removed
- Functionality maintained (run tests!)
- No new issues introduced
- All Zen principles followed
- Passes validation checklist

## Refactoring Examples

**Reference anti-pattern corrections:**
@./code-zen/context/examples/python-anti-patterns.md

**Use appropriate templates:**
@./code-zen/context/examples/python-templates.md

**Follow established patterns:**
@./code-zen/context/examples/python-patterns.md

## Refactoring Strategies

### Flatten Nested Code
```
BEFORE: Deep nesting with nested ifs
AFTER: Guard clauses with early returns
```

### Extract Magic Numbers
```
BEFORE: Literal values in code
AFTER: Named constants with descriptive names
```

### Make Behavior Explicit
```
BEFORE: Implicit defaults (db = db or get_default())
AFTER: Explicit required parameters
```

### Improve Names
```
BEFORE: Cryptic abbreviations (calc, u, amt)
AFTER: Full descriptive names (calculate_user_discount, user, amount)
```

### Add Type Safety
```
BEFORE: No type hints
AFTER: Complete type hints with Python 3.13+ syntax
```

### Separate Responsibilities
```
BEFORE: One large function doing everything
AFTER: Main function orchestrating helper functions
```

## Post-Refactoring Validation

@./code-zen/context/checklists/review-checklist.md

Verify refactored code passes all checks:
- ✅ Improved readability
- ✅ Reduced complexity
- ✅ Maintained functionality
- ✅ Follows all standards
- ✅ No anti-patterns
- ✅ All tests pass

## Success Criteria

Refactoring is successful only if:
1. Code is measurably clearer
2. Complexity metrics improved
3. All tests still pass
4. No new issues introduced
5. Team consensus on improvement
