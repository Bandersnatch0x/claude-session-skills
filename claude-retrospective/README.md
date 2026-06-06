# Claude Retrospective

Learn from past Claude Code sessions to improve future behavior with minimal, evidence-based updates.

## What This Skill Does

This skill helps you:
- **Review recent sessions** to identify repeated patterns
- **Extract lessons** from mistakes and successes
- **Update CLAUDE.md** with minimal, actionable rules
- **Create tiny skills** when procedures warrant it
- **Continuously improve** Claude Code's behavior over time

## When to Use

Use this skill when:
- Claude keeps making the same mistake
- You've corrected the same assumption multiple times
- Monthly/weekly learning review window
- After project completion (extract lessons)
- Before archiving sessions (preserve learnings)

## Quick Start

### Basic Usage

```bash
"Review last 2 weeks for patterns and suggest improvements"
```

Claude will:
1. Review recent sessions
2. Identify repeated patterns (positive and negative)
3. Propose 0-2 minimal CLAUDE.md updates
4. Show evidence for each proposal
5. Recommend how to verify improvements

### Focused Review

```bash
"Claude keeps forgetting to run tests. Review last week."
```

Claude will:
1. Focus on test-related sessions
2. Identify the specific pattern
3. Propose a targeted rule
4. Show evidence and frequency

### Project Learning

```bash
"Review all API refactor sessions and extract lessons"
```

Claude will:
1. Review project-specific work
2. Extract reusable patterns
3. Suggest where to codify learnings
4. Preserve for future similar projects

## Core Principles

### 1. Evidence-Based Only
- Every proposal backed by 3+ instances (or high impact)
- Reference specific sessions and dates
- No speculative improvements

### 2. Ruthlessly Minimal
- Prefer 1-2 line rules over paragraphs
- Update existing rules before adding new ones
- Create skills only when clearly justified
- One sharp fix beats three vague ones

### 3. Actionable & Testable
- Rules are specific actions, not philosophy
- Use imperative form ("Run tests" not "Consider testing")
- Clear triggers and expected outcomes
- Easy to verify if followed

## Output Format

Every retrospective follows this structure:

### 1. Retrospective Summary
3-5 bullets with specific evidence:
- Negative patterns (mistakes to fix)
- Positive patterns (successes to preserve)
- Each references sessions/dates

### 2. Proposed CLAUDE.md Updates
Only if high-confidence:
- Exact location (which file, which section)
- Exact text to add/replace
- One-sentence rationale

### 3. Proposed Tiny Skills
Usually 0, max 1:
- Complete SKILL.md
- Justification for why a skill (not just a rule)

### 4. Evidence & Rationale
For each proposal:
- Frequency (how many times)
- Sessions (specific dates)
- Impact (time lost, rework needed)
- Alternatives considered

### 5. Application Recommendation
- Application order
- Verification steps
- Follow-up plan

## Examples

### Example 1: Simple Rule Addition

**Input:**
```
"Review last week, I keep having to remind you to run tests"
```

**Output:**
```markdown
## 1. Retrospective Summary
- June 1, 3, 5: Forgot to run tests after code changes (3 times)

## 2. Proposed CLAUDE.md Updates

Location: ~/.claude/rules/common/development-workflow.md

Change:
After implementing code, ALWAYS run tests before presenting results.

Rationale: Forgot tests 3 times in 5 days, caused 45 min rework

## 3. Proposed Tiny Skills
None - rule is sufficient

## 4. Evidence & Rationale
[Detailed evidence with sessions, frequency, impact]

## 5. Application Recommendation
[How to apply and verify]
```

### Example 2: No Changes Needed

**Input:**
```
"Review last month for patterns"
```

**Output:**
```markdown
## 1. Retrospective Summary
- Reviewed 20 sessions from last month
- No repeated patterns strong enough to justify changes
- Current CLAUDE.md setup is working well
- Test-first workflow followed consistently
- No repeated user corrections

## Recommendation
Current setup is effective. No changes proposed.
Continue with existing workflow.
```

## Integration with Session Manager

This skill pairs perfectly with `claude-session-manager`:

**Combined monthly workflow:**
```bash
"Review last month, extract lessons, then clean up workspace"
```

Steps:
1. Retrospective reviews sessions
2. Extracts and applies lessons
3. Session manager creates handoffs
4. Archives reviewed sessions
5. Cleans workspace

See `references/session-manager-integration.md` for detailed patterns.

## Files and Structure

```
claude-retrospective/
├── SKILL.md                              # Main skill
├── README.md                             # This file
├── references/
│   ├── retrospective-prompt.md           # Prompt template
│   ├── minimal-update-rules.md           # Update guidelines
│   ├── minimal-skill-criteria.md         # When to create skills
│   ├── session-manager-integration.md    # Integration guide
│   └── examples/
│       └── good-retrospective.md         # Example output
```

## Decision Criteria

### When to Add a Rule

✅ **Add when:**
- Pattern appears 3+ times
- Or single high-impact incident
- Rule is specific and actionable
- Can be verified in next sessions

❌ **Don't add when:**
- One-off situation
- Already covered by existing rule
- Too vague or speculative
- Not actionable

### When to Create a Skill

✅ **Create when:**
- Reusable across multiple projects
- Needs scripts/references/assets
- Would be rewritten 3+ times
- Too complex for a simple rule (>5 lines)

❌ **Don't create when:**
- Achievable with 1-5 line rule
- Too specific to one project
- Based on single incident
- Duplicates existing skill

## Best Practices

### 1. Start Narrow
Review specific time windows or projects, not "everything"

### 2. Check Existing First
Read current CLAUDE.md and skills before proposing duplicates

### 3. Wait for Patterns
Single incidents don't justify rules (wait for 3+ instances)

### 4. Keep It Simple
Prefer updating existing rules over creating new ones

### 5. Verify Results
After applying changes, verify they work in next few sessions

## Common Use Cases

### Use Case 1: Repeated Mistakes
"Claude keeps assuming PostgreSQL, but I use MySQL"
→ Add framework detection rule

### Use Case 2: Workflow Gaps
"I keep having to ask you to run tests"
→ Add test-first reminder

### Use Case 3: Project Learnings
"We finished the auth refactor, extract the patterns we learned"
→ Review project, codify best practices

### Use Case 4: Monthly Improvement
"Review last month and make Claude better"
→ Identify top 1-2 improvements

## Success Metrics

After 2-3 months of regular retrospectives, you should see:

- ✅ Fewer repeated corrections
- ✅ Fewer repeated mistakes
- ✅ CLAUDE.md sharper but still concise (not bloated)
- ✅ Better default behavior
- ✅ More time on productive work, less on corrections

## FAQ

**Q: How often should I run retrospectives?**
A: Monthly is good. Weekly if you notice frequent issues. Project completion is also ideal.

**Q: What if no patterns are found?**
A: Great! Means current setup is working. No changes needed.

**Q: Can I review archived sessions?**
A: Yes! Archives are still accessible, just not in active workspace.

**Q: How many rules should be added per retrospective?**
A: Usually 0-2. One sharp improvement beats three vague ones.

**Q: What if a rule is added but still missed?**
A: May need stronger wording ("Consider" → "ALWAYS") or different approach.

**Q: Should every retrospective create a skill?**
A: No! Skills are rare. Most improvements are simple rules.

## Troubleshooting

**Problem: Too many proposed changes**
**Solution:** Pick only the sharpest 1-2. Be ruthlessly minimal.

**Problem: Changes too vague**
**Solution:** Make rules more specific with clear triggers and actions.

**Problem: Rules not followed**
**Solution:** May need stronger language or verification step.

**Problem: No patterns found**
**Solution:** Good! Current setup is working. Just maintain it.

## Next Steps

1. **Try a review:**
   ```
   "Review last 2 weeks for patterns"
   ```

2. **Read examples:**
   - See `references/examples/good-retrospective.md`

3. **Learn integration:**
   - Read `references/session-manager-integration.md`

4. **Apply improvements:**
   - Update CLAUDE.md with proposals
   - Verify in next sessions

## Related Skills

- **claude-session-manager** - Clean workspace, archive sessions
- **project-collector** - Save interesting projects for later
- **trend-collector** - Discover trending projects

## Version

**Current version:** 1.0.0  
**Last updated:** 2026-06-07  
**Compatible with:** Claude Code 1.0+  
**Adapted from:** codex-retrospective
