# Memory System Integration

How to integrate retrospective findings with Claude Code's built-in memory system.

## Claude Code Memory System Overview

Claude Code has a built-in persistent memory system:

**Structure:**
```
~/.claude/projects/<project-hash>/memory/
├── MEMORY.md                    # Index file (one-line pointers)
├── memory-name-1.md             # Individual memory files
├── memory-name-2.md
└── ...
```

**Memory file format:**
```markdown
---
name: memory-slug
description: One-line summary used for recall relevance
metadata:
  type: user | feedback | project | reference
---

<The fact. For feedback/project, follow with **Why:** and **How to apply:** lines.>
```

**Memory types:**
- `user` - Who the user is (role, expertise, preferences)
- `feedback` - Guidance on how Claude should work (corrections, confirmed approaches)
- `project` - Ongoing work, goals, constraints
- `reference` - Pointers to external resources

## Integration Strategy

### When Retrospective Finds Patterns → Save as Memory

**Retrospective output:**
```markdown
## Proposed CLAUDE.md Updates

Location: ~/.claude/rules/common/development-workflow.md
Change: After implementing code, ALWAYS run tests before presenting results.
Rationale: Forgot tests 3 times in 5 days, caused 45 min rework
```

**Convert to memory file:**
```markdown
---
name: always-run-tests-after-code
description: Always run tests after implementing code before presenting results
metadata:
  type: feedback
---

Always run tests immediately after implementing code, before presenting results to user.

**Why:** Forgot to run tests in 3 separate sessions (June 1, 3, 5), caused 60 minutes of rework finding bugs after implementation.

**How to apply:** After writing code, run relevant test suite (npm test, pytest, etc.) and fix failures before reporting completion. Include test results in response.
```

**Add to MEMORY.md:**
```markdown
- [Always run tests after code](always-run-tests-after-code.md) — Run tests immediately after implementation to catch bugs early
```

## Workflow: Retrospective + Memory

### Step 1: Run Retrospective
```bash
"Review last 2 weeks for patterns"
```

### Step 2: Identify Feedback-Type Patterns

For each retrospective finding that's about **how Claude should work**, convert to memory:

**Retrospective finding → Memory type mapping:**

| Finding Type | Memory Type | Example |
|--------------|-------------|---------|
| Claude forgot to do X | `feedback` | "Always run tests" |
| User corrected assumption | `feedback` | "Check package.json for framework" |
| Project-specific constraint | `project` | "This project uses Vue, not React" |
| User preference | `user` | "Prefers functional style over classes" |
| External resource | `reference` | "API docs at https://..." |

### Step 3: Create Memory Files

For each feedback-type finding:

```bash
# Create memory file
cat > ~/.claude/projects/<current-project>/memory/finding-name.md <<'EOF'
---
name: finding-name
description: One-line summary
metadata:
  type: feedback
---

[The lesson learned]

**Why:** [Evidence from retrospective]

**How to apply:** [Specific action]
EOF

# Add to MEMORY.md index
echo "- [Title](finding-name.md) — Brief hook" >> ~/.claude/projects/<current-project>/memory/MEMORY.md
```

### Step 4: Verify Memory Works

In next session, the memory will be loaded automatically. Verify Claude follows the guidance.

## Example: Full Integration

### Retrospective Output

```markdown
## 1. Retrospective Summary
- June 1, 3, 5: Forgot to run tests (3 times, 60 min rework)
- May 28, June 2, 4: Assumed React when project uses Vue (3 times)

## 2. Proposed Updates
1. Always run tests after code
2. Check package.json before assuming framework
```

### Convert to Memory Files

**Memory 1: `always-run-tests.md`**
```markdown
---
name: always-run-tests
description: Run tests immediately after implementing code, before presenting results
metadata:
  type: feedback
  originSessionId: current-session-id
---

Always run tests immediately after implementing code, before presenting results to user.

**Why:** Forgot to run tests in 3 separate sessions (June 1, 3, 5 2026), caused 60 minutes of rework finding bugs after initial implementation. Pattern was consistent across UI component work.

**How to apply:** 
- After writing any code (component, function, API endpoint), run relevant test suite
- For UI: `npm test` or component-specific tests
- For backend: `pytest` or equivalent
- Fix any failures before reporting completion
- Include test results (passed/failed) in response to user

Related: [[test-first-workflow]] if it exists
```

**Memory 2: `check-framework-first.md`**
```markdown
---
name: check-framework-first
description: Check package.json to identify framework before suggesting code patterns
metadata:
  type: feedback
  originSessionId: current-session-id
---

Before suggesting code patterns, check `package.json` to identify the framework (React, Vue, Svelte, etc.). Never assume.

**Why:** Assumed React patterns 3 times (May 28, June 2, June 4 2026) when project uses Vue 3. Each time user had to correct, causing friction and confusion.

**How to apply:**
- At start of coding session, read `package.json` dependencies
- Look for: `vue`, `react`, `svelte`, `@angular/core`, etc.
- Adjust code suggestions to match actual framework
- If unclear, ask user instead of assuming

**Wrong:** Suggesting `useState()` and JSX when project uses Vue Composition API  
**Correct:** Check first, then suggest `ref()` and template syntax
```

**Update MEMORY.md:**
```markdown
# Project Memory Index

- [Always run tests](always-run-tests.md) — Run tests immediately after code to catch bugs early
- [Check framework first](check-framework-first.md) — Read package.json before suggesting patterns
```

## Advantages of Memory Integration

### 1. Persistent Across Sessions
- ✅ CLAUDE.md changes require manual edits
- ✅ Memory files are loaded automatically
- ✅ Learnings survive across projects (if saved globally)

### 2. Project-Specific vs Global

**Project-specific memory:**
```
~/.claude/projects/<project-hash>/memory/
```
- Use for project-specific patterns
- Example: "This project uses Vue"

**Global memory (future feature?):**
```
~/.claude/memory/
```
- Use for universal patterns
- Example: "Always run tests"

### 3. Context-Aware Recall

Memory system loads relevant memories based on:
- Current file/directory
- Task type
- Memory descriptions

### 4. Linked Knowledge

Use `[[memory-name]]` to link related memories:
```markdown
Related to [[test-first-workflow]] and [[code-review-checklist]]
```

## Integrated Retrospective Workflow

### Full Monthly Maintenance with Memory

```bash
"Do monthly maintenance: review, update memory, clean workspace"
```

**Steps:**
1. **Retrospective** - Identify patterns
2. **Memory creation** - Save feedback-type findings
3. **CLAUDE.md updates** - Add structural rules (if needed)
4. **Session manager** - Archive and cleanup
5. **Verification** - Check memories load in next session

### Commands

**Create memory from retrospective:**
```bash
"Review last 2 weeks and save important feedback as memory files"
```

**Check existing memories:**
```bash
cat ~/.claude/projects/*/memory/MEMORY.md
```

**Verify memory in next session:**
```bash
"Show me what memories you have loaded for this project"
```

## Memory vs CLAUDE.md vs Skills

### When to Use Each

| Use Case | Solution | Example |
|----------|----------|---------|
| Universal rule | CLAUDE.md | "80% test coverage required" |
| Project-specific lesson | Memory (feedback) | "This project uses Vue" |
| User preference | Memory (user) | "Prefers functional style" |
| Complex procedure | Skill | "Database migration workflow" |
| Quick reference | Memory (reference) | "API docs URL" |

### Decision Tree

```
Retrospective finding
├─ Universal across all projects?
│  └─ Yes → CLAUDE.md rule
└─ No, project-specific or preference
   ├─ Simple fact or guidance?
   │  └─ Yes → Memory file
   └─ Complex multi-step procedure?
      └─ Yes → Skill
```

## Implementation in claude-retrospective

### Updated Output Format

Add optional **Section 6: Memory Files** after Application Recommendation:

```markdown
## 6. Proposed Memory Files (Optional)

For findings that should persist as project memory:

### Memory 1: always-run-tests

**File:** `~/.claude/projects/<current>/memory/always-run-tests.md`

**Content:**
[Full memory file with frontmatter]

**MEMORY.md entry:**
- [Always run tests](always-run-tests.md) — Run tests after code
```

### Automatic Memory Creation

When retrospective proposes memories, offer to create them:

```bash
"Apply retrospective findings including memory files"
```

Claude will:
1. Create memory files in project's memory directory
2. Update MEMORY.md index
3. Verify files are created correctly

## Best Practices

### 1. Prefer Memory for Feedback

If retrospective finds "Claude should do X differently", save as memory (not just CLAUDE.md).

### 2. Keep Memories Atomic

One memory = one lesson/fact. Don't combine multiple patterns.

### 3. Write Clear Descriptions

Memory description determines when it's recalled. Make it specific:
- ✅ "Run tests after implementing code"
- ❌ "Testing stuff"

### 4. Link Related Memories

Use `[[other-memory]]` to build knowledge graph.

### 5. Clean Up Outdated Memories

If a memory becomes obsolete, delete it and update MEMORY.md.

## Example: Full Workflow

**Input:**
```bash
"Review last month, save learnings as memory, then clean workspace"
```

**Output:**

```markdown
# Retrospective Summary
[... analysis ...]

# Proposed Memory Files

Created 2 memory files:

1. ~/.claude/projects/abc123/memory/always-run-tests.md
2. ~/.claude/projects/abc123/memory/check-framework-first.md

Updated MEMORY.md index.

# Verification

In your next session, I will automatically load these memories and follow them.

You can verify with: cat ~/.claude/projects/abc123/memory/MEMORY.md

# Session Cleanup
[... proceeds with session-manager ...]
```

## Summary

**Retrospective + Memory Integration:**

✅ **Persistent** - Survives across sessions  
✅ **Automatic** - Loaded without manual intervention  
✅ **Project-aware** - Context-specific guidance  
✅ **Linked** - Build knowledge graph over time  
✅ **Verifiable** - Easy to check what's remembered  

**Best practice:**
- Run retrospective monthly
- Save feedback-type findings as memories
- Keep CLAUDE.md for universal rules
- Use skills for complex procedures
- Clean up outdated memories periodically

This creates a **continuous learning loop** where Claude Code gets smarter with every retrospective.
