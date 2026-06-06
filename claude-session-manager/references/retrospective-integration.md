# Session Retrospective Integration

This document explains how to use `codex-retrospective` together with `claude-session-manager` for maximum effectiveness.

## Relationship Between Skills

### claude-session-manager (Operational Maintenance)
- **Focus:** Keep workspace clean and manageable
- **Activities:** Diagnose, archive, cleanup, create handoffs
- **Frequency:** Monthly or when feeling bloated
- **Output:** Freed disk space, organized archives

### codex-retrospective (Learning & Improvement)
- **Focus:** Learn from past sessions to improve future behavior
- **Activities:** Review patterns, extract lessons, update instructions
- **Frequency:** Weekly/monthly or after repeated friction
- **Output:** Updated instructions, new tiny skills

## Integrated Workflow

### Combined Monthly Maintenance + Learning

```
┌─────────────────────────────────────────────────────────┐
│ 1. Diagnosis                                            │
│    └─> Identify sessions, projects, work patterns      │
├─────────────────────────────────────────────────────────┤
│ 2. Retrospective Review (OPTIONAL but recommended)      │
│    └─> Before archiving, review recent sessions        │
│    └─> Extract lessons and patterns                    │
│    └─> Propose AGENTS.md updates or tiny skills        │
├─────────────────────────────────────────────────────────┤
│ 3. Create Handoffs                                      │
│    └─> For active work that will be archived           │
├─────────────────────────────────────────────────────────┤
│ 4. Archive & Cleanup                                    │
│    └─> Archive reviewed sessions                       │
│    └─> Clean stale worktrees, logs                     │
├─────────────────────────────────────────────────────────┤
│ 5. Verify Results                                       │
│    └─> Confirm archives, handoffs, space savings       │
└─────────────────────────────────────────────────────────┘
```

## When to Use Each Skill

### Use claude-session-manager alone when:
- You just need disk space (quick cleanup)
- Pausing work temporarily (create handoff)
- Routine monthly maintenance
- No repeated problems to learn from

### Add codex-retrospective when:
- You notice repeated corrections or friction
- Same mistakes happening across multiple sessions
- Weekly/monthly learning review window
- Want to improve future Claude Code behavior

## Usage Examples

### Example 1: Quick Maintenance (Session Manager Only)

```
User: "Clean up my Claude Code workspace, it's getting slow"

Claude uses: claude-session-manager
Steps:
1. Diagnose disk usage
2. Create handoffs for active work
3. Archive stale sessions
4. Verify results

Duration: 15-20 minutes
```

### Example 2: Learning Maintenance (Both Skills)

```
User: "Review the last 2 weeks and clean up sessions"

Claude uses: claude-session-manager + codex-retrospective integration
Steps:
1. Diagnose disk usage
2. Review last 2 weeks of sessions (retrospective)
3. Extract lessons → update AGENTS.md or create tiny skill
4. Create handoffs for active work
5. Archive reviewed sessions
6. Verify results

Duration: 30-40 minutes
```

### Example 3: Focused Learning (Retrospective Only)

```
User: "Codex keeps making the same mistake with my API endpoints. Review the last 5 API-related sessions."

Claude uses: codex-retrospective (port to Claude Code)
Steps:
1. Define review window (API endpoint sessions)
2. Review evidence
3. Propose minimal AGENTS.md update or tiny skill
4. No cleanup needed

Duration: 10-15 minutes
```

## Practical Integration Patterns

### Pattern 1: Monthly Review with Cleanup

```
Week 1 of month:
1. "Review last month's sessions for patterns and lessons"
   → Run retrospective
   → Update AGENTS.md or create skill

Week 2 of month:
2. "Clean up workspace and archive last month's sessions"
   → Run session manager
   → Archive reviewed sessions
```

### Pattern 2: Project Completion

```
When finishing a project:
1. "Review project X sessions and extract lessons"
   → Retrospective on project-specific patterns
   
2. "Create handoff and archive project X sessions"
   → Session manager cleanup
```

### Pattern 3: Friction-Driven Learning

```
When you notice repeated issues:
1. "Claude keeps forgetting to run tests. Review last 7 days."
   → Retrospective (extract lesson)
   → Update AGENTS.md: "Always run tests after code changes"
   
2. Continue working with improved behavior
3. Monthly cleanup as usual
```

## Porting Retrospective to Claude Code

Since `codex-retrospective` is designed for Codex, here's how to adapt it:

### Option A: Create claude-retrospective skill

Port the retrospective skill to Claude Code:
- Same workflow structure
- Review `~/.claude/projects/` instead of Codex paths
- Update AGENTS.md or create tiny skills
- Can reference archived sessions for learning

### Option B: Add retrospective step to session-manager

Add an optional Step 1.5 between Diagnosis and Handoff Creation:
- "Review sessions before archiving (optional)"
- Extract patterns and lessons
- Update instructions
- Then proceed with archival

### Option C: Use as separate skill (recommended for now)

Keep them separate and use together when needed:
- Cleaner separation of concerns
- More flexible usage patterns
- Can run retrospective without cleanup
- Can run cleanup without learning review

## Recommended Approach

**I recommend Option C** (separate skills with manual coordination):

1. **Install both skills:**
   - `claude-session-manager` (already created) ✅
   - `claude-retrospective` (port from codex-retrospective)

2. **Use them together when beneficial:**
   ```
   "Review last 2 weeks for patterns, then clean up sessions"
   ```
   
   Claude will:
   - First run retrospective (learning)
   - Then run session-manager (cleanup)

3. **Use them separately when appropriate:**
   ```
   "Just clean up stale worktrees" → session-manager only
   "Review API sessions for lessons" → retrospective only
   ```

## Should I Port codex-retrospective Now?

**Yes, I recommend it!** The retrospective skill would be valuable for Claude Code users who want to:
- Learn from repeated mistakes
- Improve AGENTS.md over time
- Create tiny skills from recurring patterns
- Make Claude Code better at their specific workflows

### Port Structure

```
claude-retrospective/
├── SKILL.md                              # Main skill (adapted for Claude Code)
├── README.md                             # Documentation
├── references/
│   ├── retrospective-prompt.md           # Prompt template
│   ├── agents-md-update-rules.md         # Update guidelines
│   ├── minimal-skill-criteria.md         # When to create skills
│   └── examples/
│       └── good-retrospective-output.md  # Example output
```

## Next Steps

Would you like me to:

1. ✅ **Port codex-retrospective to Claude Code** (create claude-retrospective skill)
2. ✅ **Add integration guide** to claude-session-manager README
3. ✅ **Create example combined workflow** showing both skills together

Let me know which option you prefer!
