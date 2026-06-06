# Claude Session Manager

Keep Claude Code usage fast, clean, and maintainable over long periods of heavy use.

## What This Skill Does

This skill helps you:
- **Diagnose** session bloat and identify what's taking up space
- **Create handoffs** to preserve context before archiving work
- **Safely cleanup** stale worktrees, old logs, and temporary files
- **Archive sessions** without losing important work
- **Maintain** a healthy Claude Code workspace

## When to Use

Use this skill when:
- Claude Code feels slow or bloated
- You want to clean up old sessions
- Before taking a break from a project (create handoffs)
- Your disk space is running low
- You want to archive completed work safely

## Quick Start

### 1. Diagnosis (Always Start Here)

```bash
# Manual diagnosis
claude "Run session diagnosis"

# Or use the script
bash ~/.claude/skills/claude-session-manager/scripts/diagnose.sh
```

This will show:
- Total disk usage
- Number of sessions, worktrees, projects
- Stale resources that can be cleaned
- Recommendations with safety levels (🟢 safe, 🟡 caution, 🔴 danger)

### 2. Create Handoffs (Before Archiving)

Before archiving any valuable work, create a handoff document:

```bash
claude "Create a handoff for my current authentication work"
```

Handoffs are saved to:
- Project-specific: `<project>/docs/claude-handoffs/YYYY-MM-DD-topic.md`
- Global: `~/.claude/handoffs/YYYY-MM-DD-topic.md`

### 3. Execute Cleanup (After Approval)

```bash
claude "Execute safe cleanup: archive stale worktrees and compress old logs"
```

All cleanup actions:
- Are reversible (archive, not delete)
- Require explicit approval for risky operations
- Create backups before mutations
- Log all actions taken

## Usage Examples

### Example 1: Full Maintenance Session

```bash
# Step 1: Diagnose
claude "Diagnose Claude Code session state"

# Step 2: Review recommendations and create handoffs
claude "Create handoff for API refactor work"

# Step 3: Execute safe cleanup
claude "Archive stale worktrees and old logs"

# Step 4: Verify results
claude "Show disk space freed and verify archives"
```

### Example 2: Quick Cleanup

```bash
# For when you just want quick wins
claude "Clean up stale worktrees older than 7 days"
```

### Example 3: Before Long Break

```bash
# Preserve context for later
claude "Create handoff for checkout optimization work, I'm pausing for 2 weeks"
```

### Example 4: Disk Space Emergency

```bash
# When you need space NOW
claude "Show top 10 largest directories in Claude workspace and recommend safe cleanup"
```

## Safety Features

This skill follows strict safety rules:

### 🟢 Safe (Auto-approved)
- Archive stale worktrees (>7 days, no uncommitted changes)
- Compress old logs (>30 days)
- Delete temporary files in scratch directories
- Archive completed sessions (with handoff)

### 🟡 Caution (Needs Confirmation)
- Archive sessions without handoffs
- Remove worktrees with branches that exist but aren't merged
- Archive projects with no activity >90 days

### 🔴 Dangerous (Explicit Approval Required)
- Delete any files (vs. archiving)
- Touch memory directories
- Modify configuration files
- Remove files modified <24 hours ago
- Touch anything with "credential", "secret", "key" in the path

## Files and Structure

```
claude-session-manager/
├── SKILL.md                          # Main skill instructions
├── README.md                         # This file
├── scripts/
│   └── diagnose.sh                   # Diagnosis script
├── references/
│   ├── handoff-template.md           # Template for handoffs
│   ├── maintenance-checklist.md      # Step-by-step checklist
│   └── examples/
│       ├── handoff-quality-example.md    # Example handoff
│       └── typical-diagnosis.md          # Example diagnosis report
```

## Archive Structure

After cleanup, archives are organized by date:

```
~/.claude/archives/
├── sessions/
│   └── 2026-06/
│       ├── sess-a7f3d891/
│       └── sess-b2e4c672/
├── worktrees/
│   └── 2026-06/
│       ├── auth-refactor-2026-04-12/
│       └── experiment-redis-cache/
└── logs/
    └── 2026-06/
        ├── debug-2026-03-15.log.gz
        └── session-2026-04-20.log.gz
```

## Handoff Best Practices

A good handoff document should:
- Summarize the current state in 2-4 sentences
- Document key technical decisions with rationale
- List relevant files and their purposes
- Provide environment setup and test commands
- Include clear next steps with priorities
- Note constraints and preferences
- Work standalone (no reference to old chat)

See `references/handoff-template.md` for the full structure.

## Maintenance Schedule

**Weekly:**
- Check disk usage: `du -sh ~/.claude/`
- Identify stale worktrees

**Monthly:**
- Run full diagnosis
- Archive completed sessions
- Rotate logs
- Review handoffs

**Quarterly:**
- Deep clean project directories
- Consolidate handoffs
- Update maintenance procedures

## FAQ

**Q: Will this delete my work?**
A: No. The skill archives (moves to `~/.claude/archives/`) by default, never deletes. Deletion only happens with explicit user permission.

**Q: What if I made a mistake?**
A: All operations create backups first. Archives can be restored. The diagnosis phase is always read-only.

**Q: How much space will I save?**
A: Typical cleanup saves 30-50% of disk space. The diagnosis report estimates savings before cleanup.

**Q: Can I resume archived work?**
A: Yes! Use the handoff document to resume in a fresh Claude Code session. The handoff includes a reactivation prompt.

**Q: What about my memory files?**
A: Memory files in `~/.claude/projects/*/memory/` are NEVER touched without explicit permission. They're considered critical user data.

**Q: How long does cleanup take?**
A: Diagnosis: ~3 minutes. Creating handoffs: ~10 min each. Safe cleanup execution: ~5 minutes. Total for full maintenance: 20-30 minutes.

**Q: Can I automate this?**
A: Yes, you can run the diagnosis script in a cron job. But cleanup should always be manual with user approval.

## Troubleshooting

**Problem: Diagnosis script fails**
```bash
# Check permissions
ls -la ~/.claude/

# Run with verbose output
bash -x ~/.claude/skills/claude-session-manager/scripts/diagnose.sh
```

**Problem: Archive not found after cleanup**
```bash
# Check archive location
ls -la ~/.claude/archives/

# Search for specific archive
find ~/.claude/archives -name "*keyword*"
```

**Problem: Need to restore from backup**
```bash
# List backups
ls -la ~/claude-backup-*

# Restore from most recent backup
cp -r ~/claude-backup-TIMESTAMP/* ~/.claude/
```

## Contributing

Found an issue or have suggestions? Improvements welcome:
- Better diagnosis heuristics
- Additional safety checks
- More example handoffs
- Automation scripts

## License

This skill is part of the Claude Code skills collection.

## Version

**Current version:** 1.0.0  
**Last updated:** 2026-06-07  
**Compatible with:** Claude Code 1.0+
