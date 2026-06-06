# Example: Typical Diagnosis Report

This is a real-world example of a session diagnosis and maintenance plan.

---

# Claude Code Maintenance Diagnosis Report

**Date:** 2026-06-05  
**Last Cleanup:** 2026-05-15 (21 days ago)  
**Report Duration:** ~3 minutes

## Summary

- **Total disk usage:** 3.8 GB
- **Active sessions:** 47
- **Worktrees:** 8 (5 stale)
- **Projects:** 23
- **Large files:** 12 files >10MB
- **Logs:** 156 files (89 older than 30 days)

## Findings by Category

### 🟢 Safe to Clean (Estimated savings: 1.2 GB)

**Stale worktrees (850 MB):**
- `~/.claude/.claude/worktrees/auth-refactor-2026-04-12/` - 45 days old, branch merged to main, no uncommitted changes
- `~/.claude/.claude/worktrees/experiment-redis-cache/` - 31 days old, experimental branch deleted, no uncommitted changes
- `~/.claude/.claude/worktrees/api-docs-update/` - 28 days old, changes committed and pushed, branch deleted
- `~/.claude/.claude/worktrees/test-new-ui-library/` - 52 days old, experiment abandoned, no uncommitted changes
- `~/.claude/.claude/worktrees/hotfix-login-bug/` - 38 days old, hotfix merged, no uncommitted changes

**Old logs (280 MB):**
- 89 log files older than 30 days in various project directories
- Largest: `~/.claude/projects/e-commerce-app/debug-2026-03-15.log` (45 MB)
- Can be compressed and archived

**Temporary files (95 MB):**
- `~/.claude/projects/data-pipeline/scratch/` - 18 temporary CSV files from testing
- `~/.claude/projects/frontend-redesign/.cache/` - Build cache, safe to regenerate

### 🟡 Needs Review (Potential savings: 890 MB)

**Large session data:**
- Session `sess-a7f3d891` (Backend API Refactor): 245 MB, last active 12 days ago
  - Has extensive code exploration history
  - No handoff document exists
  - **Recommendation:** Create handoff before archiving (work appears in-progress)

- Session `sess-b2e4c672` (Database Migration): 178 MB, last active 8 days ago
  - Contains migration planning and testing
  - No handoff document exists
  - **Recommendation:** Create handoff (complex work, valuable context)

**Worktrees with unclear status:**
- `~/.claude/.claude/worktrees/performance-optimization/` - 14 days old, branch still active
  - No uncommitted changes, but branch not merged
  - **Recommendation:** Check with user if work is complete

- `~/.claude/.claude/worktrees/security-audit-fixes/` - 9 days old, has branch
  - No uncommitted changes, but branch has unpushed commits
  - **Recommendation:** Verify if commits should be pushed before cleanup

**Old projects with large state:**
- `~/.claude/projects/prototype-ml-pipeline/` (312 MB) - no activity in 94 days
  - Contains large model files and training data
  - **Recommendation:** Archive project data, or confirm if still needed

### 🔴 Do Not Touch

**Active session data (<7 days):**
- Session `sess-c9f1d234` (Checkout Optimization): 156 MB, last active 2 hours ago
- Session `sess-d3a2e567` (Mobile App Testing): 89 MB, last active yesterday
- 15 other sessions active within last 7 days

**Worktrees with uncommitted changes:**
- `~/.claude/.claude/worktrees/feature-user-profiles/` 
  - 4 days old, has 12 uncommitted files
  - Active work in progress

**Critical directories (never touch):**
- `~/.claude/projects/*/memory/` - user memory files (348 MB total)
- `~/.claude/skills/` - installed skills (156 MB)
- `~/.claude/rules/` - coding rules (12 MB)
- `~/.claude/settings.json` - global configuration

## Detailed Breakdown

### Disk Usage by Category

```
Total: 3.8 GB
├── Projects: 2.1 GB (55%)
│   ├── e-commerce-app: 658 MB
│   ├── data-pipeline: 445 MB
│   ├── frontend-redesign: 387 MB
│   ├── prototype-ml-pipeline: 312 MB
│   └── (19 other projects): 398 MB
├── Sessions: 1.2 GB (32%)
│   ├── Active (<7 days): 678 MB
│   ├── Recent (7-30 days): 423 MB
│   └── Old (>30 days): 99 MB
├── Worktrees: 285 MB (7%)
│   ├── Stale (>7 days): 185 MB
│   └── Active: 100 MB
├── Skills: 156 MB (4%)
└── Other (logs, cache, etc.): 77 MB (2%)
```

### Session Activity Timeline

```
Last 7 days:    17 sessions (active, do not touch)
8-30 days:      24 sessions (candidates for handoff + archive)
31-90 days:     6 sessions (archive with handoff)
>90 days:       0 sessions (already cleaned)
```

### Worktree Status

```
Active (<7 days):                   3 worktrees
Stale (>7 days, no changes):        5 worktrees (safe to clean)
Stale (>7 days, uncommitted):       0 worktrees
```

## Recommendations

### Priority 1: Create Handoffs (Effort: 20 minutes)

**Before archiving these sessions, create handoff documents:**

1. **Session sess-a7f3d891** (Backend API Refactor) - 245 MB
   - Complex API redesign work
   - Multiple architectural decisions documented in chat
   - **Action:** Create handoff at `docs/claude-handoffs/2026-06-05-api-refactor.md`
   - **Estimated time:** 10 minutes

2. **Session sess-b2e4c672** (Database Migration) - 178 MB
   - Multi-phase migration plan
   - Testing results and rollback procedures
   - **Action:** Create handoff at `docs/claude-handoffs/2026-06-05-db-migration.md`
   - **Estimated time:** 10 minutes

### Priority 2: Safe Cleanup (Effort: 5 minutes, Savings: 1.2 GB)

**These actions are safe to execute immediately:**

1. **Archive stale worktrees** (850 MB saved)
   ```bash
   mkdir -p ~/.claude/archives/worktrees/2026-06
   mv ~/.claude/.claude/worktrees/auth-refactor-2026-04-12 ~/.claude/archives/worktrees/2026-06/
   mv ~/.claude/.claude/worktrees/experiment-redis-cache ~/.claude/archives/worktrees/2026-06/
   mv ~/.claude/.claude/worktrees/api-docs-update ~/.claude/archives/worktrees/2026-06/
   mv ~/.claude/.claude/worktrees/test-new-ui-library ~/.claude/archives/worktrees/2026-06/
   mv ~/.claude/.claude/worktrees/hotfix-login-bug ~/.claude/archives/worktrees/2026-06/
   ```

2. **Compress and archive old logs** (280 MB saved)
   ```bash
   mkdir -p ~/.claude/archives/logs/2026-06
   find ~/.claude/ -name "*.log" -mtime +30 -exec gzip {} \;
   find ~/.claude/ -name "*.log.gz" -exec mv {} ~/.claude/archives/logs/2026-06/ \;
   ```

3. **Clean temporary files** (95 MB saved)
   ```bash
   rm -rf ~/.claude/projects/data-pipeline/scratch/*.csv
   rm -rf ~/.claude/projects/frontend-redesign/.cache/
   ```

### Priority 3: Review and Archive Sessions (Effort: 30 minutes, Savings: 890 MB)

**After creating handoffs, archive these sessions:**

1. **Archive sessions with handoffs**
   ```bash
   mkdir -p ~/.claude/archives/sessions/2026-06
   mv ~/.claude/context-mode/sessions/sess-a7f3d891 ~/.claude/archives/sessions/2026-06/
   mv ~/.claude/context-mode/sessions/sess-b2e4c672 ~/.claude/archives/sessions/2026-06/
   ```

2. **Verify worktree status with user**
   - Check if `performance-optimization` work is complete
   - Verify if `security-audit-fixes` commits should be pushed

3. **Review old project data**
   - Confirm if `prototype-ml-pipeline` (312 MB) is still needed
   - Archive or delete based on user decision

## Execution Plan

### Phase 1: Handoffs (Do First)
1. Create handoff for API Refactor session
2. Create handoff for Database Migration session
3. Verify handoffs are complete and readable

### Phase 2: Safe Cleanup (Can Run Immediately)
1. Create backup of critical directories
2. Archive stale worktrees (5 worktrees)
3. Compress and archive old logs (89 files)
4. Delete temporary files (scratch directories)
5. Update `.last-cleanup` timestamp

### Phase 3: Review Items (Need User Confirmation)
1. Ask about `performance-optimization` worktree status
2. Ask about `security-audit-fixes` unpushed commits
3. Ask about `prototype-ml-pipeline` project data
4. Archive sessions after handoffs are created

## Expected Results

**After Phase 1 (Handoffs):**
- 2 new handoff documents
- No disk space saved, but continuity preserved

**After Phase 2 (Safe Cleanup):**
- Disk usage: 3.8 GB → 2.6 GB (1.2 GB freed, 32% reduction)
- Stale worktrees: 5 → 0
- Old logs: 89 → 0 (compressed and archived)
- Temporary files removed

**After Phase 3 (Review Items):**
- Potential additional savings: 890 MB (depending on user decisions)
- Final disk usage: potentially ~1.7 GB (55% total reduction)

## Next Steps

**Immediate action needed:**
1. User approval for Phase 2 (safe cleanup)
2. Create handoffs for Priority 1 items
3. Execute Phase 2 cleanup
4. Answer review questions for Phase 3

**Future maintenance:**
- Schedule monthly cleanup (add to calendar)
- Create handoffs before pausing work (make it a habit)
- Monitor disk usage weekly: `du -sh ~/.claude/`

## Backup Plan

Before executing any cleanup:

```bash
# Create timestamped backup
BACKUP_DIR=~/claude-backup-2026-06-05
mkdir -p "$BACKUP_DIR"
cp -r ~/.claude/projects "$BACKUP_DIR/"
cp -r ~/.claude/context-mode/sessions/sess-a7f3d891 "$BACKUP_DIR/"
cp -r ~/.claude/context-mode/sessions/sess-b2e4c672 "$BACKUP_DIR/"
echo "Backup created at: $BACKUP_DIR"
du -sh "$BACKUP_DIR"
```

**Backup location:** `~/claude-backup-2026-06-05` (external drive recommended)

---

## Notes

- This diagnosis took ~3 minutes to complete
- All recommendations are conservative (when in doubt, preserve data)
- User confirmation required before executing Phase 2
- Handoffs (Phase 1) are critical before archiving any active work
- All cleanup actions are reversible (archives, not deletions)

**Questions for user:**
1. Approve Phase 2 safe cleanup? (1.2 GB savings)
2. Want to proceed with handoff creation for the 2 priority sessions?
3. Any concerns about the recommended actions?
