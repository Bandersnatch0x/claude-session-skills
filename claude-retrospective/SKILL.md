---
name: claude-retrospective
description: Use when reviewing recent Claude Code sessions to improve future behavior with minimal, evidence-based updates to CLAUDE.md, local instructions, or tiny reusable skills. This skill should be used after repeated friction, repeated corrections, or during weekly/monthly review windows to extract lessons from past work.
---

# Claude Retrospective

Run a structured self-improvement loop for Claude Code.

The goal is to turn repeated friction from recent sessions into the smallest possible durable improvement. Prefer tiny instruction updates and tiny skills over broad rewrites.

## Core Rules

- Ground every proposal in repeated evidence from real recent sessions
- Prefer updating an existing rule over creating a new one
- Prefer a short CLAUDE.md addition over a new skill when both would work
- Only extract a new skill when it would clearly save time in multiple future sessions
- If the evidence is weak, say that no change is justified

## Trigger Conditions

Use this skill when:
- The user says "review recent sessions", "do a retrospective", "what should Claude learn"
- After repeated corrections or friction patterns
- During weekly/monthly review windows
- The user asks "Claude keeps making mistake X, extract the lesson"
- Before archiving sessions (optional but recommended)

## Workflow

### Step 1: Define the Review Window

Start by fixing the scope:
- Last N days (e.g., "last 7 days", "last month")
- A named project (e.g., "all API refactor work")
- A cluster of similar threads (e.g., "authentication sessions")
- A specific repeated failure mode (e.g., "forgot to run tests")

If the scope is too wide, narrow it before analyzing.

### Step 2: Review the Evidence

Look for patterns in the review window:

**Negative patterns (to fix):**
- Repeated corrections from the user
- Repeated assumption errors
- Repeated context loss or re-explanation
- Same mistake across multiple sessions

**Positive patterns (to preserve):**
- Successful approaches that worked well
- Good decisions that should become defaults
- Workflows that saved time

**Before proposing changes:**
- Read current `CLAUDE.md` or `~/.claude/rules/` to avoid duplication
- Check existing skills to see if one already covers this
- Verify the pattern is repeated (not a one-off)

### Step 3: Produce Output in Strict Order

Use this exact section order:

1. **Retrospective Summary**
2. **Proposed CLAUDE.md Updates** (only if high-confidence)
3. **Proposed New or Updated Tiny Skills** (only if clearly justified)
4. **Evidence & Rationale**
5. **Application Recommendation**

If there are no high-confidence updates, omit sections 2 and 3 and say so plainly.

### Step 4: Keep Changes Minimal

**Allowed outputs (pick ONE):**
- One small CLAUDE.md addition (2-5 lines)
- One small CLAUDE.md tightening (clarify existing rule)
- One tiny skill (focused on one repeatable task)
- One tiny skill revision (improve existing skill)

**One sharp improvement is better than three vague ones.**

## Output Standard

### 1. Retrospective Summary

3-5 bullets, each grounded in specific evidence:
- Reference specific sessions, dates, or narrow time windows
- Include both failures and successful patterns
- Be concrete, not vague

### 2. Proposed CLAUDE.md Updates

Only include if you have high-confidence minimal changes.

For each update:
- **Location:** Exact section in CLAUDE.md or which rule file
- **Change:** Exact text to add or replace
- **Rationale:** One-sentence explanation tied to evidence

### 3. Proposed New or Updated Tiny Skills

At most 1 new skill, and usually 0.

Each proposal must include:
- **Suggested name:** skill-name-here
- **Complete SKILL.md:** With frontmatter and instructions
- **Justification:** Why a skill (not just a rule) is needed

### 4. Evidence & Rationale

Connect every proposal to observed patterns:
- **Frequency:** How many times?
- **Sessions:** Which specific sessions or dates?
- **Impact:** What was the cost?
- **Alternative considered:** Why not a different fix?

### 5. Application Recommendation

Recommend:
- **Application order:** If multiple changes, which order
- **Verification:** How to verify the change is working
- **Follow-up:** Whether to re-run retrospective later

### 6. Proposed Memory Files (Optional)

For findings about **how Claude should work** (feedback type):

**When to create memory:**
- Repeated corrections from user (e.g., "always run tests")
- Project-specific constraints (e.g., "this project uses Vue")
- User preferences (e.g., "prefers functional style")

**Memory file format:**
```markdown
---
name: memory-slug
description: One-line summary for recall relevance
metadata:
  type: feedback | project | user | reference
---

[The lesson learned]

**Why:** [Evidence from retrospective]

**How to apply:** [Specific action]
```

**Save to:** `~/.claude/projects/<project-hash>/memory/`

**Update index:** Add entry to `MEMORY.md`

See `references/memory-integration.md` for full integration guide.

## Integration with Session Manager

This skill pairs well with `claude-session-manager`:

**Recommended combined workflow:**
1. **Retrospective first:** Review recent sessions, extract lessons
2. **Update instructions:** Apply CLAUDE.md changes or create tiny skills
3. **Session cleanup:** Archive reviewed sessions with `claude-session-manager`

See `references/session-manager-integration.md` for detailed patterns.

## Success Criteria

This skill is working well when:
- Claude Code repeats fewer avoidable mistakes
- CLAUDE.md stays small but sharper
- New tiny skills are rare and clearly justified
- Future similar sessions start with better defaults
- User corrections decrease over time

## References

- `references/retrospective-prompt.md` - Strict prompt template
- `references/minimal-update-rules.md` - What changes are acceptable
- `references/minimal-skill-criteria.md` - When to create skills
- `references/session-manager-integration.md` - Integration with session-manager
- `references/memory-integration.md` - Integration with Claude Code memory system
- `references/examples/good-retrospective.md` - Example output

## Anti-Patterns (Avoid These)

❌ **Too broad:** "Review everything"  
❌ **No evidence:** "Claude might benefit from X"  
❌ **Over-engineering:** Creating a skill for a 2-line rule  
❌ **Duplicate rules:** Not checking existing CLAUDE.md first  
❌ **Vague proposals:** "Be better at testing"  
❌ **One-off fixes:** Rules based on single incidents
