# Common Code Red Flags

Critical anti-patterns that violate Zen of Python principles.

## Red Flags - Reject If Found

- 🚨 **"This is too clever"** → Violates Simple > Complex
- 🚨 **"Only works if you know X"** → Violates Explicit > Implicit
- 🚨 **"5+ levels of if/for"** → Violates Flat > Nested
- 🚨 **"Line 120+ characters"** → Violates Sparse > Dense (80 max!)
- 🚨 **"Can't explain how it works"** → Violates "Hard to explain = bad idea"
- 🚨 **"Using default values with 'or'"** → Implicit behavior
- 🚨 **"Bare except:"** → Silent errors
- 🚨 **"Line > 80 chars"** → Style violation

## Usage

Include this file in checklists and validation workflows to ensure consistent anti-pattern detection.
