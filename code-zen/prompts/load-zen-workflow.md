# Load Zen of Python Workflow

Apply Zen of Python principles throughout this session.

## Core Principles

@../spec/principles/zen-principles-spec.md

## Universal Standards

@../spec/universal/naming-conventions-spec.md
@../spec/universal/code-structure-spec.md
@../spec/universal/error-handling-spec.md

## Implementation Guidance

@../context/guides/zen-implementation-guide.md

## Practical Patterns

@../context/examples/python-patterns.md
@../context/examples/python-templates.md

## Anti-Patterns to Avoid

@../context/examples/python-anti-patterns.md

## Pre-Code Validation

@../context/checklists/pre-code-checklist.md

## Workflow Instructions

**Before generating code:**
1. Review pre-code checklist from context
2. Identify implementation context (function/class/module/error/refactor)
3. Consult decision matrix in zen-implementation-guide
4. Choose appropriate template from python-templates

**During code generation:**
1. Apply naming conventions from spec
2. Use guard clauses (flat > nested)
3. Make all intentions explicit
4. Handle errors explicitly (never silent)

**After code generation:**
1. Self-verify against all Zen principles
2. Check for red flags
3. Ensure all validations pass

**Conflict Resolution:**
When principles conflict, follow hierarchy:
1. Readability ALWAYS wins
2. Explicit > Implicit
3. Simple > Complex
4. Practicality > Purity (with clear benefit)
5. Consistency > Cleverness

Apply these Zen principles to ALL code generated in this session.
