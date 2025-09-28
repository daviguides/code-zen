# File References Quick Guide for Code Assistants

Universal syntax for Claude Code, Gemini CLI, Codex CLI, and others.

## Syntax

### Auto-Include (When Required)
```markdown
`@./file.md`                # Force assistant to read file NOW
`@./src/main.py`            # Include file content immediately
`@./docs/`                  # Include directory listing now
```

**Use when:** Content is immediately required for the current task.

### Reference (Let Assistant Decide)
```markdown
`./file.md`                 # Reference file, assistant chooses if/when to read
[Setup](./file.md)          # Traditional link for humans
```

**Use when:** Providing context or reference, assistant can decide if reading is needed.

## Essential Rules

1. **Always use `@./` prefix** - explicit, unambiguous, works everywhere
2. **Use backticks** - better visibility and consistency
3. **Organize by context** - group related files together

```markdown
✅ Good: `@./config.yaml`
❌ Avoid: `@config.yaml` (ambiguous location)
❌ Avoid: @./config.yaml (no visual highlight)
```

## Common Patterns

```markdown
## Project Files
- `@./README.md` - Project overview
- `@./package.json` - Dependencies
- `@./src/main.py` - Entry point
- `@./config/` - Configuration directory

## Code Review
- `@./src/auth.py` - Updated authentication
- `@./tests/test_auth.py` - New test cases
- `@./docs/auth.md` - Documentation updates
```

## Path Types

```markdown
@./file.md                  # Current directory
@./src/components/Button.js # Subdirectory
@../shared/utils.py         # Parent directory
@/absolute/path/file.md     # Absolute path (when needed)
```

## Quick Reference

| Purpose | Syntax | When to Use |
|---------|--------|-------------|
| **Force include** | `@./file.md` | Content required NOW |
| **Reference** | `` `./file.md` `` | Let assistant decide |
| **Manual link** | `[text](./file.md)` | Links for humans |
| **Directory** | `@./src/` | Need folder contents |

## Assistant Differences

| Feature | Claude Code | Gemini CLI | Codex CLI |
|---------|-------------|------------|-----------|
| **Auto CLAUDE.md** | ✅ | ❌ | ❌ |
| **Directory support** | ✅ Full | ✅ Good | ✅ Good |
| **Large files** | ✅ Smart | ✅ Good | ✅ Efficient |
| **Path preference** | Any | `./` explicit | Any |

## Troubleshooting

- **File not found**: Verify path with `ls ./`
- **Ambiguous location**: Use `@./` prefix always
- **Large files**: Reference sections or summarize
- **Permissions**: Check file access or use relative paths

## Summary

- **`@./file.md`** - Force include when content is immediately required
- **`./file.md`** - Reference for assistant to decide if reading is needed
- **Use `@` deliberately** - not by default, only when content is essential
- **Works universally** across all major code assistants

Choose the right syntax based on whether you need the content NOW or just want to reference it.