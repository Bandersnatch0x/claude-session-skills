# Claude Code Maintenance Checklist

Use this checklist for safe session cleanup and maintenance operations.

## Phase 1: Diagnosis (Report-Only)

**Objective:** Understand current state without making any changes.

### Session State Analysis

- [ ] Check last cleanup date
  ```bash
  cat ~/.claude/.last-cleanup
  ```
  
- [ ] Review session statistics
  ```bash
  cat ~/.claude/.session-stats.json
  ```
  
- [ ] List active sessions
  ```bash
  ls -lh ~/.claude/context-mode/sessions/ 2>/dev/null
  ```

### Disk Usage Analysis

- [ ] Calculate total Claude Code disk usage
  ```bash
  du -sh ~/.claude/
  ```
  
- [ ] Identify large directories (top 10)
  ```bash
  du -h ~/.claude/ | sort -rh | head -10
  ```
  
- [ ] Find large files (>10MB)
  ```bash
  find ~/.claude/ -type f -size +10M -exec ls -lh {} \; 2>/dev/null
  ```

### Worktree Analysis

- [ ] List active worktrees
  ```bash
  ls -lh ~/.claude/.claude/worktrees/ 2>/dev/null || echo "No worktrees directory"
  ```
  
- [ ] Find stale worktrees (>7 days old)
  ```bash
  find ~/.claude/.claude/worktrees/ -type d -maxdepth 1 -mtime +7 2>/dev/null
  ```
  
- [ ] Check for uncommitted changes in worktrees
  ```bash
  for wt in ~/.claude/.claude/worktrees/*/; do
    echo "=== $wt ==="
    git -C "$wt" status --short 2>/dev/null || echo "Not a git repo"
  done
  ```

### Project State Analysis

- [ ] Count project directories
  ```bash
  ls -1 ~/.claude/projects/ 2>/dev/null | wc -l
  ```
  
- [ ] Identify projects with large state
  ```bash
  du -sh ~/.claude/projects/*/ 2>/dev/null | sort -rh | head -5
  ```
  
- [ ] Check for observation archives
  ```bash
  find ~/.claude/homunculus/projects/ -name "observations.archive" -exec ls -lh {} \; 2>/dev/null
  ```

### Log Analysis

- [ ] Find log files
  ```bash
  find ~/.claude/ -name "*.log" -o -name "*.log.*" 2>/dev/null
  ```
  
- [ ] Identify old logs (>30 days)
  ```bash
  find ~/.claude/ -name "*.log" -mtime +30 2>/dev/null
  ```

### Diagnosis Report Template

```markdown
# Claude Code Maintenance Diagnosis Report

**Date:** YYYY-MM-DD
**Last Cleanup:** [date from .last-cleanup]

## Summary

- **Total disk usage:** X.X GB
- **Active sessions:** N
- **Worktrees:** N (M stale)
- **Projects:** N
- **Large files:** N files >10MB

## Findings

### 🟢 Safe to Clean
- [ ] Stale worktrees with no uncommitted changes
- [ ] Old logs (>30 days)
- [ ] Temporary files in scratch directories

### 🟡 Needs Review
- [ ] Large session data (>100MB)
- [ ] Worktrees with uncommitted changes
- [ ] Projects with no recent activity (>90 days)

### 🔴 Do Not Touch
- [ ] Active session data (<24 hours)
- [ ] Memory files in projects/*/memory/
- [ ] Skills and rules directories
- [ ] Configuration files

## Recommendations

1. **Priority 1:** [action with estimated space savings]
2. **Priority 2:** [action with estimated space savings]
3. **Priority 3:** [action with estimated space savings]

## Next Steps

- [ ] Create handoffs for any active work
- [ ] Backup important state before cleanup
- [ ] Execute safe cleanup actions
- [ ] Verify results
```

## Phase 2: Handoff Creation

**Objective:** Preserve continuity for valuable work before archiving.

### Identify Work Needing Handoffs

- [ ] Review recent session activity
- [ ] Identify in-progress projects
- [ ] Check for uncommitted work in worktrees
- [ ] Note any open questions or blockers

### Create Handoff Documents

- [ ] Use `references/handoff-template.md` as structure
- [ ] Document current state clearly
- [ ] List next steps with priorities
- [ ] Include reactivation prompt
- [ ] Save to appropriate location:
  - Project: `<project>/docs/claude-handoffs/YYYY-MM-DD-topic.md`
  - Global: `~/.claude/handoffs/YYYY-MM-DD-topic.md`

### Verify Handoff Quality

- [ ] Can a fresh session understand the context?
- [ ] Are next steps clear and actionable?
- [ ] Are environment setup instructions complete?
- [ ] Are key decisions documented with rationale?
- [ ] Are constraints and preferences noted?

## Phase 3: Archive Planning

**Objective:** Identify safe archive candidates with explicit safety levels.

### Session Archives

- [ ] Identify completed sessions (with handoff)
- [ ] Identify experimental sessions (no handoff needed)
- [ ] Mark sessions modified in last 24 hours as 🔴 DO NOT TOUCH

**Safety Assessment:**
- 🟢 **SAFE:** Session >7 days old, has handoff, no active references
- 🟡 **CAUTION:** Session >7 days old, no handoff, appears complete
- 🔴 **DANGEROUS:** Session <7 days old, or has active work

### Worktree Archives

- [ ] List all worktrees with last modified date
- [ ] Check each for uncommitted changes
- [ ] Verify no active processes are using them

**Safety Assessment:**
- 🟢 **SAFE:** Worktree >7 days old, no uncommitted changes, branch merged or deleted
- 🟡 **CAUTION:** Worktree >7 days old, no uncommitted changes, branch still exists
- 🔴 **DANGEROUS:** Worktree has uncommitted changes or modified <7 days ago

### Log Rotation

- [ ] List logs by age and size
- [ ] Identify logs >30 days old (safe to archive)
- [ ] Identify logs >100MB (candidates for compression)

**Safety Assessment:**
- 🟢 **SAFE:** Logs >30 days old
- 🟡 **CAUTION:** Logs 7-30 days old (might be useful for debugging)
- 🔴 **DANGEROUS:** Logs <7 days old

## Phase 4: Backup

**Objective:** Create safety net before any mutations.

### Create Backup

- [ ] Choose backup location (external drive or cloud storage recommended)
- [ ] Create timestamped backup directory
  ```bash
  BACKUP_DIR=~/claude-backup-$(date +%Y%m%d-%H%M%S)
  mkdir -p "$BACKUP_DIR"
  ```
  
- [ ] Backup critical directories
  ```bash
  cp -r ~/.claude/projects "$BACKUP_DIR/"
  cp -r ~/.claude/handoffs "$BACKUP_DIR/" 2>/dev/null || true
  cp ~/.claude/.session-stats.json "$BACKUP_DIR/" 2>/dev/null || true
  ```
  
- [ ] Verify backup integrity
  ```bash
  du -sh "$BACKUP_DIR"
  ls -lR "$BACKUP_DIR" | head -20
  ```
  
- [ ] Document backup location for user

## Phase 5: Apply Changes

**Objective:** Execute planned cleanup actions safely.

### Pre-Flight Checks

- [ ] Handoffs created for all active work? ✓
- [ ] Backup completed successfully? ✓
- [ ] User approved the cleanup plan? ✓
- [ ] Exact paths verified? ✓

### Create Archive Directories

```bash
mkdir -p ~/.claude/archives/{sessions,worktrees,logs}/$(date +%Y-%m)
```

### Archive Sessions (🟢 Safe Only)

```bash
# Move completed sessions to archive
mv ~/.claude/context-mode/sessions/old-session-id \
   ~/.claude/archives/sessions/$(date +%Y-%m)/
```

### Archive Worktrees (🟢 Safe Only)

```bash
# Verify no uncommitted changes
cd ~/.claude/.claude/worktrees/old-worktree
git status --short  # Should be empty

# Archive the worktree
mv ~/.claude/.claude/worktrees/old-worktree \
   ~/.claude/archives/worktrees/$(date +%Y-%m)/
```

### Rotate Logs (🟢 Safe Only)

```bash
# Compress and archive old logs
find ~/.claude/ -name "*.log" -mtime +30 -exec gzip {} \;
find ~/.claude/ -name "*.log.gz" -exec mv {} ~/.claude/archives/logs/$(date +%Y-%m)/ \;
```

### Safety Rules During Application

**NEVER do these without explicit user confirmation:**
- Delete any file (prefer archiving)
- Touch files in `~/.claude/projects/*/memory/`
- Modify `~/.claude/skills/` or `~/.claude/rules/`
- Change `~/.claude/settings.json`
- Remove files modified in last 24 hours
- Touch anything containing "credential", "secret", "key", "token"

**ALWAYS do these:**
- Verify paths before moving
- Use `mv` (move) instead of `rm` (delete)
- Log all actions taken
- Keep archive structure organized by date

## Phase 6: Verification

**Objective:** Confirm cleanup succeeded and nothing important was lost.

### Verify Archives

- [ ] Check archive directories exist
  ```bash
  ls -lh ~/.claude/archives/sessions/$(date +%Y-%m)/
  ls -lh ~/.claude/archives/worktrees/$(date +%Y-%m)/
  ls -lh ~/.claude/archives/logs/$(date +%Y-%m)/
  ```
  
- [ ] Verify archived content is accessible
  ```bash
  # Spot-check random archived files
  ```

### Verify Handoffs

- [ ] List all handoff documents
  ```bash
  find ~/.claude/handoffs -name "*.md" 2>/dev/null
  find . -path "*/docs/claude-handoffs/*.md" 2>/dev/null
  ```
  
- [ ] Spot-check handoff readability
  ```bash
  head -50 ~/.claude/handoffs/latest-handoff.md
  ```

### Calculate Space Savings

- [ ] Measure new disk usage
  ```bash
  du -sh ~/.claude/
  ```
  
- [ ] Compare to baseline (from diagnosis)
- [ ] Calculate space freed

### Generate Final Report

```markdown
# Claude Code Maintenance Completion Report

**Date:** YYYY-MM-DD
**Duration:** [start time] - [end time]

## Results

### Space Freed
- **Before:** X.X GB
- **After:** Y.Y GB
- **Saved:** Z.Z GB (N%)

### Actions Taken
- Sessions archived: N
- Worktrees cleaned: N
- Logs rotated: N
- Handoffs created: N

### Archives Created
- Location: `~/.claude/archives/`
- Sessions: `sessions/YYYY-MM/`
- Worktrees: `worktrees/YYYY-MM/`
- Logs: `logs/YYYY-MM/`

### Handoffs Created
- Location: `~/.claude/handoffs/`
- Files: [list handoff filenames]

### Verification
- [✓] All archives accessible
- [✓] Handoffs readable
- [✓] No important work lost
- [✓] Active workspace functional

## Remaining Hotspots

[List any remaining large directories or files that need attention]

## Recommendations

[Suggestions for ongoing maintenance]

## Backup Location

[Path to backup created before cleanup]
```

## Ongoing Maintenance Schedule

**Weekly:**
- Check disk usage
- Identify stale worktrees

**Monthly:**
- Run full diagnosis
- Archive completed sessions
- Rotate logs
- Review handoffs for old projects

**Quarterly:**
- Clean up project directories
- Review and consolidate handoffs
- Update maintenance procedures

## Emergency Recovery

If something goes wrong:

1. **Stop immediately** - Don't continue cleanup
2. **Check backup** - Verify backup is intact
3. **Restore from backup:**
   ```bash
   cp -r ~/claude-backup-TIMESTAMP/* ~/.claude/
   ```
4. **Verify restoration:**
   ```bash
   ls -lR ~/.claude/ | head -50
   ```
5. **Report what happened** to user

## Notes

- Always prefer caution over speed
- When in doubt, ask the user
- Archive, don't delete
- Backup before mutations
- Document all actions
