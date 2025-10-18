# Code Zen Architecture

Code Zen follows the **Gradient Architecture** pattern - a 7-layer system designed to eliminate duplication and maintain Single Source of Truth (SSOT) for Claude Code plugins.

## Directory Structure

```
code-zen/
├── commands/                          # Layer 7: Thin wrappers (≤5 lines)
│   ├── load-zen-context.md
│   ├── load-python-context.md
│   ├── zen-check.md
│   └── zen-refactor.md
├── agents/                            # Layer 6: Specialized behaviors
│   ├── zen-reviewer.md
│   └── python-zen-expert.md
├── code-zen/                          # Bundle: Core content (spec + context + prompts)
│   ├── spec/                          # Layer 1: SPECS (normative definitions)
│   │   ├── principles/
│   │   │   └── zen-principles-spec.md
│   │   ├── universal/
│   │   │   ├── naming-conventions-spec.md
│   │   │   ├── code-structure-spec.md
│   │   │   └── error-handling-spec.md
│   │   └── python/
│   │       ├── python-language-spec.md
│   │       ├── python-style-spec.md
│   │       ├── python-libraries-spec.md
│   │       └── python-tdd-spec.md
│   ├── context/                       # Layer 2: CONTEXT (applied examples)
│   │   ├── examples/
│   │   │   ├── python-templates.md
│   │   │   ├── python-patterns.md
│   │   │   └── python-anti-patterns.md
│   │   ├── guides/
│   │   │   ├── python-quick-guide.md
│   │   │   └── zen-implementation-guide.md
│   │   └── checklists/
│   │       ├── pre-code-checklist.md
│   │       └── review-checklist.md
│   └── prompts/                       # Layer 3: PROMPTS (orchestration)
│       ├── load-zen-workflow.md
│       ├── load-python-workflow.md
│       ├── zen-check-workflow.md
│       └── zen-refactor-workflow.md
├── docs/                              # Documentation site (Jekyll)
│   └── to_review/                     # Human-focused content
│       └── zen_theory_explained.md
├── ARCHITECTURE.md                    # This file
├── CLAUDE.md                          # Project instructions for Claude Code
├── README.md                          # User-facing documentation
└── install.sh                         # Installation script

Note: Layer 4 (SCRIPTS) and Layer 5 (HOOKS) not used in this plugin.
```

## Layer Responsibilities

### Layer 1: SPECS (Normative - THE WHAT)

**Location**: `code-zen/spec/`

**Purpose**: Define rules, principles, and requirements. Pure specification.

**Characteristics**:
- ✅ Normative definitions
- ✅ Rules and constraints
- ✅ "Must", "Should", "Must not" language
- ❌ No code examples
- ❌ No implementation guidance
- ❌ No stories or narratives

**Example Files**:
- `spec/principles/zen-principles-spec.md` - 19 Zen principles with hierarchy
- `spec/python/python-language-spec.md` - Python ≥3.13 requirements
- `spec/universal/error-handling-spec.md` - Error handling rules

**Duplication Ratio Target**: 1.0 (single source, no duplication)

### Layer 2: CONTEXT (Applied - THE HOW)

**Location**: `code-zen/context/`

**Purpose**: Show how to apply specs through examples, templates, patterns, guides.

**Characteristics**:
- ✅ Complete code examples
- ✅ Templates for common structures
- ✅ Pattern demonstrations
- ✅ Anti-pattern corrections
- ✅ Practical guides and checklists
- ❌ No normative definitions (reference specs instead)

**Subdirectories**:
- `examples/` - Templates, patterns, anti-patterns
- `guides/` - Implementation guides, quick references
- `checklists/` - Pre-code and review validation lists

**Example Files**:
- `context/examples/python-templates.md` - Function/class/async templates
- `context/examples/python-anti-patterns.md` - ❌ Bad vs ✅ Good examples
- `context/checklists/review-checklist.md` - Validation checklist

**Duplication Ratio Target**: 1.0 (examples stored once, referenced many times)

### Layer 3: PROMPTS (Orchestration - THE ACTION)

**Location**: `code-zen/prompts/`

**Purpose**: Orchestrate workflows by referencing specs and context. Thin coordination layer.

**Characteristics**:
- ✅ >50% content should be @ references
- ✅ Minimal inline content (workflow instructions only)
- ✅ References to spec/ and context/
- ❌ No duplicated examples
- ❌ No duplicated rules

**Reference Pattern**:
```markdown
## Standards to Apply

@../spec/python/python-language-spec.md
@../spec/python/python-style-spec.md
@../spec/universal/naming-conventions-spec.md

## Implementation Patterns

@../context/examples/python-patterns.md
@../context/examples/python-templates.md

## Validation

@../context/checklists/pre-code-checklist.md
```

**Example Files**:
- `prompts/load-python-workflow.md` - Orchestrates Python context loading
- `prompts/zen-refactor-workflow.md` - Orchestrates refactoring process

**Duplication Ratio Target**: <1.1 (mostly references, minimal unique content)

### Layer 4: SCRIPTS (Automation)

**Not used in this plugin**. Reserved for future automation scripts.

### Layer 5: HOOKS (Event Handlers)

**Not used in this plugin**. Reserved for future event-driven behaviors.

### Layer 6: AGENTS (Specialized Behaviors)

**Location**: `agents/`

**Purpose**: Specialized agent behaviors with unique instructions.

**Characteristics**:
- ✅ Reference all standards from spec/
- ✅ Reference all examples from context/
- ✅ >30% content should be @ references
- ✅ Keep only unique agent-specific behavior
- ✅ Can be longer than commands (100-250 lines acceptable)
- ❌ No duplicated templates or examples

**Example Files**:
- `agents/zen-reviewer.md` (190 lines) - Review process, output format, severity assessment
- `agents/python-zen-expert.md` (234 lines) - Code generation approach, response formats

**Duplication Ratio Target**: <1.2 (specialized content + references)

### Layer 7: COMMANDS (User Interface)

**Location**: `commands/`

**Purpose**: Ultra-thin wrappers that users invoke. Pure delegation.

**Characteristics**:
- ✅ ≤5 lines (excluding frontmatter)
- ✅ 100% reference to prompts
- ✅ Frontmatter with description
- ❌ No inline content beyond @ reference

**Template**:
```markdown
---
description: [Brief description]
---

@./code-zen/prompts/workflow-name.md
```

**Example Files**:
- `commands/load-python-context.md` (5 lines) → references prompts/load-python-workflow.md
- `commands/zen-refactor.md` (5 lines) → references prompts/zen-refactor-workflow.md

**Duplication Ratio Target**: 1.0 (pure references, zero duplication)

## Reference System

### @ Syntax

Code Zen uses `@./path` syntax for cross-file references:

```markdown
# From a PROMPT file (code-zen/prompts/load-python-workflow.md)
@../spec/python/python-language-spec.md          # Up to bundle, down to spec/
@../context/examples/python-patterns.md          # Up to bundle, down to context/

# From a COMMAND file (commands/load-python-context.md)
@./code-zen/prompts/load-python-workflow.md      # From root to bundle

# From an AGENT file (agents/python-zen-expert.md)
@./code-zen/spec/python/python-language-spec.md  # From root to bundle
```

### Reference Flow

```
User invokes: /load-python-context
              ↓
COMMAND: commands/load-python-context.md (5 lines)
              ↓
         @ references
              ↓
PROMPT: code-zen/prompts/load-python-workflow.md (>50% references)
              ↓
         @ references
              ↓
SPECS: code-zen/spec/python/*.md (normative definitions)
CONTEXT: code-zen/context/examples/*.md (applied examples)
```

## Gradient Principles Applied

### 1. Single Source of Truth (SSOT)

Each concept exists exactly once:
- Zen principles defined once: `spec/principles/zen-principles-spec.md`
- Python standards defined once: `spec/python/python-language-spec.md`
- Templates defined once: `context/examples/python-templates.md`
- All other files reference these sources

### 2. Layer Separation

Clear boundaries between layers:
- **SPECS**: Pure definitions, no examples
- **CONTEXT**: Pure examples, no definitions (reference specs)
- **PROMPTS**: Pure orchestration, no content (reference specs + context)
- **COMMANDS**: Pure delegation, no logic (reference prompts)

### 3. Anti-Duplication

Before migration:
- 5,600 total lines
- 1.8x duplication ratio
- Commands 370-500 lines each (78x-100x oversized)
- 0% reference usage in prompts

After migration:
- ~3,400 total lines (39% reduction)
- <1.1x duplication ratio target
- Commands 4-5 lines each (100% compliant)
- >50% reference usage in prompts
- >30% reference usage in agents

### 4. Thin Wrappers

Each layer should be as thin as possible:
- **COMMANDS**: ≤5 lines (pure delegation)
- **PROMPTS**: >50% references (orchestration)
- **AGENTS**: >30% references (specialized behavior + references)

## Metrics and Validation

### Duplication Ratio

```
Duplication Ratio = Total Lines / Unique Content Lines
```

**Targets**:
- SPECS: 1.0 (no duplication allowed)
- CONTEXT: 1.0 (examples stored once)
- PROMPTS: <1.1 (mostly references)
- COMMANDS: 1.0 (pure references)
- AGENTS: <1.2 (specialized + references)
- **Overall**: <1.1

### Reference Density

```
Reference Density = (Lines with @ / Total Lines) × 100%
```

**Targets**:
- PROMPTS: >50%
- AGENTS: >30%
- COMMANDS: 100%

### Size Constraints

**Hard Limits**:
- COMMANDS: ≤5 lines (excluding frontmatter)

**Soft Guidelines**:
- SPECS: ≤500 lines per file
- CONTEXT: ≤400 lines per file
- PROMPTS: ≤200 lines per file
- AGENTS: 100-250 lines per file

## Migration Summary

### Phase 1-3: Bundle Creation
Created the bundle structure with proper layer separation:
- 8 SPEC files (normative)
- 5 CONTEXT files (applied)
- 4 PROMPT files (orchestration)

### Phase 4: Content Triage
Moved non-LLM content to `docs/to_review/`:
- `zen_theory_explained.md` (theory for humans)

### Phase 5-6: Thin Wrappers
Reduced commands from 1,560 lines to 19 lines:
- Each command: 4-5 lines
- 98-99% size reduction per command

### Phase 7: Agent Refactoring
Reduced agents from 885 lines to 424 lines:
- zen-reviewer: 336 → 190 lines (43% reduction)
- python-zen-expert: 549 → 234 lines (57% reduction)

### Overall Impact

**Before Migration**:
- Total: ~5,600 lines
- Duplication ratio: 1.8x
- Reference usage: 0%
- Command sizes: 370-500 lines

**After Migration**:
- Total: ~3,400 lines (39% reduction)
- Duplication ratio: <1.1x (target)
- Reference usage: >50% (prompts), >30% (agents), 100% (commands)
- Command sizes: 4-5 lines (100% compliant)
- Lines eliminated: ~2,200

## Usage Patterns

### For Users

Install globally:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/daviguides/code-zen/main/install.sh)"
```

The installer copies `code-zen/` bundle to `~/.claude/code-zen/`, making standards available globally.

### In Projects

Reference from project CLAUDE.md:
```markdown
# Project Coding Standards

@./zen-code-standards/coding-standards.md

# Or use specific commands
Use `/load-python-context` to load Python standards for this session.
```

### Command Invocation

```bash
/load-zen-context       # Load Zen principles
/load-python-context    # Load Python standards
/zen-check             # Validate code compliance
/zen-refactor          # Refactor following Zen
```

## Future Enhancements

### Layer 4: SCRIPTS (Planned)

Potential automation scripts:
- Code validation scripts
- Metrics calculation
- Standard enforcement checks

### Layer 5: HOOKS (Planned)

Potential event-driven behaviors:
- Pre-commit validation
- Auto-formatting triggers
- Standard compliance checks

## References

- **Gradient Architecture**: 7-layer plugin architecture for Claude Code
- **SSOT Principle**: Single Source of Truth - each concept exists once
- **Reference Syntax**: `@./path` for cross-file references
- **Duplication Ratio**: Metric for measuring content reuse (target <1.1)

---

**This architecture ensures maintainability, eliminates duplication, and provides a clear hierarchy from high-level commands down to detailed specifications.**
