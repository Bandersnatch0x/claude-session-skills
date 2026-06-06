# Claude Session Skills

A complete session management and continuous learning system for Claude Code.

## Overview

Two complementary skills that work together to keep your Claude Code workspace clean and continuously improve Claude's behavior:

- **claude-session-manager** - Diagnose, archive, and maintain your workspace
- **claude-retrospective** - Learn from past sessions to improve future behavior

## Features

### 🧹 Session Manager
- 📊 **Diagnose** workspace state (disk usage, stale resources)
- 📝 **Create handoffs** to preserve context before archiving
- 🗄️ **Safe archival** of sessions, worktrees, and logs
- 🧹 **Cleanup** stale resources and free disk space

### 🧠 Retrospective
- 🔍 **Review** recent sessions to identify patterns
- 📚 **Extract lessons** from mistakes and successes
- ✏️ **Minimal updates** to CLAUDE.md or create tiny skills
- 💾 **Memory integration** - save findings as persistent memories
- 📈 **Continuous improvement** - reduce repeated mistakes

## Quick Start

### Installation

```bash
# Copy skills to Claude Code skills directory
cp -r claude-session-manager ~/.claude/skills/
cp -r claude-retrospective ~/.claude/skills/
```

### Basic Usage

**Diagnose workspace:**
```bash
"Diagnose Claude Code workspace state"
```

**Review and learn:**
```bash
"Review last 2 weeks for patterns and save as memory"
```

**Full monthly maintenance:**
```bash
"Review last month, save learnings as memory, then clean up workspace"
```

## Documentation

Each skill includes complete documentation:

- `SKILL.md` - Skill definition and workflow
- `README.md` - Complete usage guide
- `QUICKSTART.md` - Quick start guide (Chinese)
- `references/` - Templates, checklists, and integration guides
- `examples/` - Real-world examples

## Integration

### Session Manager + Retrospective

**Combined monthly workflow:**
1. Review recent sessions (retrospective)
2. Extract and save lessons as memory
3. Create handoffs for active work (session-manager)
4. Archive sessions and clean up (session-manager)

See `references/session-manager-integration.md` and `references/retrospective-integration.md` for detailed patterns.

### Memory System Integration

Retrospective findings can be saved as Claude Code memories:

```markdown
---
name: always-run-tests
description: Run tests after implementing code
metadata:
  type: feedback
---

Always run tests immediately after implementing code.

**Why:** Forgot tests 3 times, caused 60 min rework

**How to apply:** Run test suite, fix failures, report results
```

Memories are automatically loaded in future sessions. See `references/memory-integration.md`.

## Use Cases

### Scenario 1: Repeated Mistakes

**Problem:** "Claude keeps forgetting to run tests"

**Solution:**
```bash
"Claude keeps forgetting tests, review last week and save as memory"
```

**Result:** Memory file created, automatically applied in next sessions

---

### Scenario 2: Project Completion

**Situation:** API refactor project complete

**Action:**
```bash
"Review API refactor sessions, extract lessons, save memory, create handoff, archive"
```

**Result:** Lessons preserved, handoff created, workspace cleaned

---

### Scenario 3: Monthly Learning

**Timing:** First of each month

**Action:**
```bash
"Review last month, extract patterns, save memories, clean workspace"
```

**Result:** Continuous improvement + clean workspace

## Requirements

- Claude Code 1.0+
- Bash shell (for diagnostic scripts)
- Git repository (for worktree features)

## File Structure

```
claude-session-manager/
├── SKILL.md                          # Main skill
├── README.md                         # Full documentation
├── QUICKSTART.md                     # Quick start (Chinese)
├── scripts/
│   └── diagnose.sh                   # Diagnostic script
└── references/
    ├── handoff-template.md           # Handoff template
    ├── maintenance-checklist.md      # Maintenance checklist
    ├── retrospective-integration.md  # Retrospective integration
    └── examples/
        ├── handoff-quality-example.md
        └── typical-diagnosis.md

claude-retrospective/
├── SKILL.md                              # Main skill (with memory integration)
├── README.md                             # Full documentation
└── references/
    ├── retrospective-prompt.md           # Prompt template
    ├── minimal-update-rules.md           # Update guidelines
    ├── minimal-skill-criteria.md         # Skill criteria
    ├── session-manager-integration.md    # Session Manager integration
    ├── memory-integration.md             # Memory system integration ✨
    └── examples/
        └── good-retrospective.md
```

## Examples

### Example 1: Quick Cleanup

```bash
"Just clean up stale worktrees and logs"
```

### Example 2: Learning Focus

```bash
"Review last 2 weeks, identify patterns, save important feedback as memory"
```

### Example 3: Full Maintenance

```bash
"Do monthly maintenance: review, extract lessons, save memory, clean workspace"
```

## Success Metrics

After 2-3 months of use:

**From retrospective:**
- ✅ Fewer repeated corrections
- ✅ CLAUDE.md stays concise
- ✅ Memory files work automatically
- ✅ Better default behavior

**From session-manager:**
- ✅ Clean workspace
- ✅ Easy to resume old work
- ✅ Good handoff documentation

**Combined:**
- ✅ Less maintenance time
- ✅ More productive work
- ✅ Continuous improvement
- ✅ Perfect work continuity

## Contributing

Improvements welcome! Areas for contribution:
- Better diagnostic heuristics
- Additional safety checks
- More example handoffs
- Integration patterns
- Automation scripts

## Credits

- Inspired by `codex-fluent` and `codex-retrospective` from the Codex community
- Adapted for Claude Code with memory system integration
- Created with Claude Code (Opus 4.8)

## License

MIT License - See LICENSE file for details

## Version

**Current version:** 1.0.0  
**Last updated:** 2026-06-07  
**Compatible with:** Claude Code 1.0+

---

**Keywords:** claude-code, session-management, workspace-maintenance, continuous-learning, memory-integration, retrospective, handoff, cleanup, archive
