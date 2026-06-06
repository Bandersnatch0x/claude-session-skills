# Session Manager Integration

How to use `claude-retrospective` with `claude-session-manager` for maximum effectiveness.

## Why Use Both?

**claude-session-manager** keeps your workspace clean.  
**claude-retrospective** makes Claude Code smarter over time.

Together: Clean workspace + Continuous learning = Optimal workflow

## Integration Patterns

### Pattern 1: Monthly Review + Cleanup

**Best for:** Regular maintenance routine

```bash
Week 1: Learning
"Review last month's Claude Code sessions for patterns and lessons"
→ Extract lessons, update CLAUDE.md or create skills

Week 2: Cleanup  
"Clean up workspace and archive last month's sessions"
→ Create handoffs, archive sessions, free disk space
```

**Benefits:**
- Learn before archiving (don't lose valuable lessons)
- Separate concerns (thinking vs. doing)
- Monthly rhythm is sustainable

---

### Pattern 2: Project Completion

**Best for:** When finishing a major feature or project

```bash
Step 1: Review
"Review all project X sessions and extract lessons"
→ What worked well? What mistakes to avoid?

Step 2: Archive
"Create handoff and archive project X sessions"
→ Document for future continuation
```

**Benefits:**
- Capture project-specific learnings
- Clean handoff for potential resumption
- Project becomes a teaching example

---

### Pattern 3: Friction-Driven Learning

**Best for:** When you notice repeated issues

```bash
Immediate:
"Claude keeps forgetting to run tests. Review last 7 days."
→ Extract lesson, add rule to CLAUDE.md

Later (monthly):
"Clean up last month's sessions"
→ Regular maintenance continues
```

**Benefits:**
- Fix problems as they appear
- Don't wait for scheduled review
- Faster improvement cycle

---

### Pattern 4: Combined Single Session

**Best for:** Efficient monthly maintenance

```bash
"Review last 2 weeks for patterns, then clean up sessions"

Claude will:
1. Run retrospective (learning phase)
   - Review recent sessions
   - Identify patterns
   - Propose CLAUDE.md updates or skills
   
2. Apply improvements
   - Update instructions
   - Create tiny skills if needed
   
3. Run session manager (cleanup phase)
   - Create handoffs for active work
   - Archive reviewed sessions
   - Clean stale worktrees and logs
   
4. Verify
   - Confirm improvements applied
   - Verify archives and space savings
```

**Benefits:**
- One command, full maintenance
- Learning informs what to preserve in handoffs
- Efficient use of time

## Recommended Workflow

### Monthly Maintenance (Recommended)

```
1. Review (retrospective)
   └─> "Review last month for repeated patterns"
   └─> Extract 0-2 minimal improvements
   └─> Update CLAUDE.md or create tiny skill

2. Apply changes
   └─> Add rules to appropriate files
   └─> Test in next session

3. Diagnose (session manager)
   └─> "Diagnose workspace state"
   └─> Identify safe cleanup candidates

4. Create handoffs (session manager)
   └─> For any active work being archived
   └─> Use template from session-manager

5. Archive & cleanup (session manager)
   └─> Archive reviewed sessions
   └─> Clean stale worktrees, logs
   └─> Verify archives and savings

6. Verify improvements
   └─> Observe next few sessions
   └─> Confirm rules are followed
   └─> Adjust if needed
```

**Time estimate:** 30-40 minutes total

---

### Quick Cleanup (No Learning)

When you just need space or maintenance:

```bash
"Clean up Claude Code workspace"

Uses: session-manager only
Steps: Diagnose → Handoffs → Archive → Verify
Time: 15-20 minutes
```

---

### Quick Learning (No Cleanup)

When you notice repeated issues:

```bash
"Claude keeps making mistake X, review recent sessions"

Uses: retrospective only  
Steps: Review → Extract lesson → Apply rule
Time: 10-15 minutes
```

## Command Examples

### Example 1: Full Monthly Maintenance

```bash
"Do monthly maintenance: review last 4 weeks for patterns, extract lessons, clean up workspace"
```

Claude will:
- Review 4 weeks of sessions
- Identify repeated patterns
- Propose minimal CLAUDE.md updates
- Create handoffs for active work
- Archive old sessions
- Clean stale resources
- Report results

---

### Example 2: Focused Learning

```bash
"I noticed you keep assuming React when I use Vue. Review frontend sessions from last 2 weeks."
```

Claude will:
- Review Vue-related sessions
- Identify assumption pattern
- Propose rule: "Check package.json for framework before assuming"
- No cleanup (focused on learning)

---

### Example 3: Project Wrap-Up

```bash
"Project auth-refactor is done. Review all related sessions, extract lessons, create handoff, and archive."
```

Claude will:
- Review auth-refactor sessions
- Extract authentication patterns learned
- Update security rules if needed
- Create comprehensive handoff
- Archive project sessions

---

### Example 4: Quick Cleanup Only

```bash
"Just clean up stale worktrees and logs, no review needed"
```

Claude will:
- Skip retrospective
- Run session-manager only
- Fast maintenance

## When to Use Which Skill

### Use retrospective when:
- ✅ Repeated corrections or mistakes
- ✅ Weekly/monthly learning review
- ✅ Want to improve future behavior
- ✅ Project completion (extract lessons)

### Use session-manager when:
- ✅ Need disk space
- ✅ Workspace feels bloated
- ✅ Pausing work (need handoff)
- ✅ Routine maintenance

### Use both when:
- ✅ Monthly maintenance window
- ✅ Major project completion
- ✅ Workspace cleanup + learning opportunity
- ✅ Want continuous improvement

## Integration Tips

### Tip 1: Review Before Archive
Always run retrospective before session-manager when doing monthly maintenance. You might discover patterns in sessions about to be archived.

### Tip 2: Document Improvements in Handoffs
When creating handoffs, mention recent CLAUDE.md updates relevant to that work.

### Tip 3: Archive Reviewed Sessions
After retrospective, the reviewed sessions are good candidates for archival (lessons extracted, can be safely stored).

### Tip 4: Use Archives for Learning
When running retrospectives, you can review archived sessions too (they're still accessible, just not active).

### Tip 5: Track Improvement Over Time
Note when rules were added. In future retrospectives, check if those rules reduced the problem.

## Success Metrics

After using both skills together for 2-3 months, you should see:

**From retrospective:**
- ✅ Fewer repeated corrections
- ✅ CLAUDE.md sharper but still concise
- ✅ Better default behavior

**From session-manager:**
- ✅ Cleaner workspace
- ✅ Good handoffs for paused work
- ✅ Easy to resume old projects

**Combined:**
- ✅ Less time on maintenance
- ✅ More time on productive work
- ✅ Claude Code improves continuously

## Troubleshooting

**Problem:** Retrospective finds no patterns  
**Solution:** Good! Means current setup is working. Just run session-manager for cleanup.

**Problem:** Too many small improvements suggested  
**Solution:** Pick only the sharpest 1-2 changes. Ruthless minimalism.

**Problem:** Rules added but still missed  
**Solution:** Rule might need stronger wording (e.g., "Consider" → "ALWAYS")

**Problem:** Skills created but rarely used  
**Solution:** Next retrospective should recommend removing them

## Summary

**Best practice:**
1. Monthly: Review (retrospective) → Apply improvements → Clean up (session-manager)
2. As needed: Quick retrospective when friction appears
3. As needed: Quick cleanup when space is low

**Key insight:**
Learn from the past (retrospective), preserve the present (session-manager), improve the future (better CLAUDE.md).

Together these skills create a continuous improvement loop for Claude Code.
