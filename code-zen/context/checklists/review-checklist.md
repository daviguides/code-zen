# Code Review Checklist

## Post-Implementation Verification

### ✅ Group 1: Foundations (CRITICAL)

**Beautiful (PEP 8):**
- [ ] Code follows PEP 8 (indentation, spacing, line length ≤80)
- [ ] Names are consistent with project patterns
- [ ] Structure is clean and organized

**Explicit (Clear Intentions):**
- [ ] All code intentions are clear
- [ ] No "magic" or implicit behaviors
- [ ] Can be understood without special knowledge

**Readability (Human-First):**
- [ ] A junior developer could understand this code
- [ ] Code tells a clear story
- [ ] Avoided unnecessary cleverness

### ✅ Group 2: Structure (CRITICAL)

**Simple vs Complex:**
- [ ] Used the simplest solution for this problem
- [ ] If complex, problem is inherently complex
- [ ] Avoided over-engineering

**Flat (No Deep Nesting):**
- [ ] No unnecessary nesting levels
- [ ] Used guard clauses or early returns where appropriate
- [ ] Control flow is linear and clear

**Sparse (Proper Spacing):**
- [ ] Code has adequate spacing
- [ ] No dense or compressed lines
- [ ] Complex expressions broken into multiple lines

### ✅ Group 3: Decisions (WHEN APPLICABLE)

**Special Cases:**
- [ ] Maintained consistency even in edge cases
- [ ] No unique solutions for "special" cases
- [ ] Followed established patterns

**Practicality vs Purity:**
- [ ] If broke convention, clear practical benefit exists
- [ ] Documented reason for exception
- [ ] Benefit justifies the deviation

**Ambiguity:**
- [ ] No assumptions about inputs or behavior
- [ ] Forced clarity where ambiguity existed
- [ ] Documented necessary assumptions

**One Obvious Way:**
- [ ] Used Pythonic approach
- [ ] Followed established language conventions
- [ ] Did not reinvent the wheel

### ✅ Group 4: Implementation Details

**Type Hints:**
- [ ] All function parameters have type hints
- [ ] All return types are annotated
- [ ] Used Python 3.13+ syntax (`list[str]` not `List[str]`)
- [ ] Union types use `|` not `Union`

**Function Structure:**
- [ ] Functions have single responsibility
- [ ] Function names are descriptive
- [ ] Parameters use keyword arguments when multiple
- [ ] Input validation at function start
- [ ] No hidden side effects

**Class Structure:**
- [ ] Single clear responsibility
- [ ] Public interface is intuitive
- [ ] Constructor validates initial state
- [ ] Private methods are clear helpers

**Error Handling:**
- [ ] No bare `except:` clauses
- [ ] Specific exception types used
- [ ] Error messages include context
- [ ] Exception chaining with `from e`
- [ ] Errors never pass silently (unless explicitly intended)

**Documentation:**
- [ ] Module docstring exists
- [ ] Class docstrings exist
- [ ] Public function docstrings exist
- [ ] Docstrings are ≤80 columns
- [ ] Args, Returns, Raises documented where applicable

**Imports:**
- [ ] Organized in 3 groups (stdlib, third-party, local)
- [ ] Blank lines between groups
- [ ] No unused imports
- [ ] Used pathlib over os.path

**Style:**
- [ ] Used f-strings (not % or .format())
- [ ] No magic numbers (named constants used)
- [ ] Trailing commas in multi-line constructs
- [ ] Lines ≤80 characters

## Severity-Based Issues

### 🔴 High Severity (Fix Immediately)
- Silent error handling (bare except)
- Missing type hints
- Deep nesting (> 3 levels)
- Missing input validation
- Security issues
- Functions > 100 lines

### 🟡 Medium Severity (Fix Soon)
- PEP 8 violations
- Unclear naming
- Magic numbers
- Missing docstrings
- Old Python syntax
- Not using pathlib

### 🟢 Low Severity (Nice to Have)
- Missing trailing commas
- Import organization
- Minor style issues
- Docstring formatting

## Final Approval Checklist

**ALL items must be TRUE before approving:**

**Fundamentals:**
- ✅ Code follows PEP 8 automatically
- ✅ All intentions are explicit
- ✅ Readability prioritized over cleverness

**Structure:**
- ✅ Solution is simple for the problem
- ✅ Structure is flat (no unnecessary nesting)
- ✅ Code is well-spaced and not dense

**Pragmatism:**
- ✅ Consistency maintained
- ✅ Ambiguities avoided
- ✅ One obvious way chosen

**Errors:**
- ✅ Errors never pass silently
- ✅ When suppressed, explicitly intentional

**Implementation:**
- ✅ Code delivered (not perfect is enemy of good)
- ✅ Quality maintained (not rushed)
- ✅ Implementation is easy to explain

**Organization:**
- ✅ Namespaces used effectively

**If ANY item is ❌ → Request changes before merging**

## Context-Specific Checks

### For New Features
- [ ] Feature can be explained in one sentence
- [ ] Interface is intuitive
- [ ] Follows project patterns
- [ ] Tests included

### For Refactoring
- [ ] Code is clearer than before
- [ ] Reduced unnecessary complexity
- [ ] Maintained original functionality
- [ ] Improved test coverage

### For Bug Fixes
- [ ] Root cause is clear
- [ ] Added validation to prevent recurrence
- [ ] Fix is targeted (not over-engineered)
- [ ] Added regression test

## Red Flags - Reject If Found

- 🚨 **"This is too clever"** → Violates Simple > Complex
- 🚨 **"Only works if you know X"** → Violates Explicit > Implicit
- 🚨 **"5+ levels of if/for"** → Violates Flat > Nested
- 🚨 **"Can't explain how it works"** → Violates "Hard to explain = bad"
- 🚨 **"Bare except:"** → Silent errors
- 🚨 **"Line > 80 chars"** → Style violation

## Review Summary Template

```
## Code Review Summary

**Files Reviewed**: X
**Total Issues**: X

### Issues by Severity
- 🔴 High: X issues (fix immediately)
- 🟡 Medium: X issues (fix soon)
- 🟢 Low: X issues (nice to have)

### Issues by Principle
- Beautiful (PEP 8): X issues
- Explicit: X issues
- Simple: X issues
- Flat: X issues
- Readability: X issues
- Error Handling: X issues

### Top Priority Fixes
1. [Most critical issue]
2. [Second most critical]
3. [Third most critical]

### Positive Observations
- ✅ [Good practice found]
- ✅ [Another good practice]

### Recommendation
- [ ] Approve
- [ ] Request changes
- [ ] Needs discussion
```
