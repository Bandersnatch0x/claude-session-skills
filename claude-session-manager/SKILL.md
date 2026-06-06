---
name: claude-session-manager
description: Use when Claude Code session state feels heavy, slow, or cluttered, and safe diagnosis, handoff creation, archive planning, or local cleanup guidance is needed without losing valuable history. This skill should be used when the user wants to manage sessions, says things like "clean up sessions", "archive old work", "create handoff", or when workspace maintenance is needed.
---

# Claude Session Manager

Keep Claude Code usage fast, clean, and maintainable over long periods of heavy use.

This skill provides operational fluency: reducing active clutter, preserving continuity with good handoffs, and making local cleanup safe instead of stressful.

## Core Rules

- Diagnose first. The first pass is always report-only.
- Create handoff before archive for any work that may be resumed.
- Archive, never delete, unless the user explicitly requests deletion.
- Backup before mutations when touching local Claude Code state.
- Never claim an action is safe without inspecting the exact paths and targets.

## Trigger Conditions

Use this skill when:
- The user says "session feels slow", "Claude Code is bloated", "clean up sessions"
- The user wants to "archive old work", "create handoff", "prepare session for later"
- The user asks for "workspace maintenance", "session diagnosis", "cleanup guidance"
- Before long breaks when work should be preserved for later continuation

## Workflow

### Step 1: Diagnosis (Report-Only)

Start with a report-only pass. Inspect likely sources of drag:

**Session State:**
- `~/.claude/.session-stats.json` - current session statistics
- `~/.claude/context-mode/sessions/` - active session data
- `~/.claude/.last-cleanup` - last cleanup timestamp

**Workspace State:**
- `~/.claude/worktrees/` - active worktrees (can be large)
- Project-specific `.claude/` directories in repositories
- Temporary files and scratch directories

**Memory and Projects:**
- `~/.claude/projects/*/` - project-specific state
- `~/.claude/homunculus/projects/*/` - observation archives
- Large log files or debug output

**What to Report:**
- Total disk usage by category
- Number of active sessions
- Stale worktrees (>7 days old)
- Large files (>10MB)
- Last cleanup date
- Recommended actions (with safety level)

**Safety Levels:**
- 🟢 **SAFE**: Can proceed without risk (e.g., cleanup stale worktrees)
- 🟡 **CAUTION**: Needs user confirmation (e.g., archive old sessions)
- 🔴 **DANGEROUS**: High risk, explicit approval required (e.g., delete memory files)

Do NOT mutate anything during diagnosis.

### Step 2: Handoff Creation

Before archiving valuable work, create handoffs using `references/handoff-template.md`.

**When to Create Handoffs:**
- Before archiving sessions with in-progress work
- Before long breaks (>1 week)
- When switching to a different project
- Before major refactoring or cleanup

**Handoff Quality:**
A good handoff should enable a fresh Claude Code session to resume work without the original conversation history.

**Save Location:**
- Project handoffs: `<project-root>/docs/claude-handoffs/YYYY-MM-DD-topic.md`
- Global handoffs: `~/.claude/handoffs/YYYY-MM-DD-topic.md`

See `references/handoff-template.md` for the standard structure.

### Step 3: Archive and Maintenance Plan

Only after handoffs exist for important work, identify:

**Safe Archive Candidates:**
- Completed project sessions (with handoff)
- Experimental work (not production)
- Temporary exploration sessions
- Old worktrees (>7 days, no uncommitted changes)

**Safe Log Rotation Candidates:**
- Debug logs (>30 days old)
- Session transcripts (>60 days old)
- Temporary command output

**Stale Cleanup Candidates:**
- Worktrees with no uncommitted changes
- Scratch directories (clearly marked as temporary)
- Build artifacts in `.claude/` directories

**Uncertain (Needs Confirmation):**
- Sessions with uncommitted work but no handoff
- Large files without clear purpose
- Workspace state from unknown projects

Be explicit about what is safe, what is uncertain, and what needs confirmation.

### Step 4: Apply Carefully

If the user approves changes:

**Pre-Apply Checklist:**
- [ ] Name exact target paths
- [ ] Verify paths exist and match expectations
- [ ] Create backup if mutating important state
- [ ] Prefer moving to archive over deletion
- [ ] Avoid touching credentials, memory stores, or global skills without explicit permission

**Archive Locations:**
- Session archives: `~/.claude/archives/sessions/YYYY-MM/`
- Worktree archives: `~/.claude/archives/worktrees/YYYY-MM/`
- Log archives: `~/.claude/archives/logs/YYYY-MM/`

**Commands to Use:**
- Move (safe): `mv source destination`
- Copy backup: `cp -r source backup-location`
- Verify before delete: `ls -lh target` then confirm with user

**Never Touch Without Permission:**
- `~/.claude/projects/*/memory/` - user memory files
- `~/.claude/skills/` - installed skills
- `~/.claude/rules/` - coding rules
- `~/.claude/settings.json` - global configuration
- Any file containing credentials or secrets

### Step 5: Verify Results

After cleanup, report:

**Before/After Comparison:**
- Disk space freed (MB/GB)
- Number of sessions archived
- Number of worktrees cleaned
- Number of files moved/deleted

**Verification Checks:**
- [ ] Archived material is still accessible
- [ ] Handoff documents are readable and complete
- [ ] No important work was lost
- [ ] Active workspace is functional
- [ ] Note any remaining hotspots or recommendations

**Test Commands:**
- List archives: `ls -lh ~/.claude/archives/`
- Verify handoffs: `cat ~/.claude/handoffs/*.md`
- Check disk usage: `du -sh ~/.claude/`

## Safety Boundaries

**STOP and ask for explicit confirmation before:**
- Deleting any transcripts or workspace files
- Touching credentials, API keys, or secret material
- Mutating global configuration or memory stores
- Archiving work without a handoff
- Removing files from active projects
- Killing processes or services

**Red Flags (Always Confirm):**
- Files modified in the last 24 hours
- Uncommitted git changes in worktrees
- Active session data
- Any path containing "memory", "credential", "secret", "key"

If Claude Code or another process may still be using a file, inspect first and confirm user intent before moving it.

## Archive Conventions

Use consistent naming and location for archives:

**Session Handoffs:**
- Project-specific: `<project>/docs/claude-handoffs/YYYY-MM-DD-topic.md`
- Global: `~/.claude/handoffs/YYYY-MM-DD-topic.md`

**Archived Material:**
- Sessions: `~/.claude/archives/sessions/YYYY-MM/`
- Worktrees: `~/.claude/archives/worktrees/YYYY-MM/`
- Logs: `~/.claude/archives/logs/YYYY-MM/`

**Naming Format:**
- Use ISO dates: `YYYY-MM-DD`
- Brief topic slug: `project-name-feature`
- Full example: `2026-06-07-browser-harness-auth-fix.md`

Adapt to the user's existing layout when one already exists.

## Quick Commands

**Diagnosis:**
```bash
# Check disk usage
du -sh ~/.claude/

# List worktrees
ls -lh ~/.claude/.claude/worktrees/ 2>/dev/null

# Session stats
cat ~/.claude/.session-stats.json

# Last cleanup
cat ~/.claude/.last-cleanup
```

**Safe Cleanup:**
```bash
# Find stale worktrees (>7 days, read-only check)
find ~/.claude/.claude/worktrees/ -type d -mtime +7 2>/dev/null

# Check large files
find ~/.claude/ -type f -size +10M 2>/dev/null
```

## References

- `references/handoff-template.md` - Standard structure for high-quality continuation docs
- `references/maintenance-checklist.md` - Safe report/apply checklist
- `references/examples/handoff-quality-example.md` - Example of a compact high-value handoff
- `references/examples/typical-diagnosis.md` - Example diagnosis and improvement report

## Success Criteria

This skill works well when:
- Active Claude Code state is smaller and easier to reason about
- Important work has clear handoffs before leaving the active workspace
- Cleanup actions are reversible and well-documented
- Future continuation starts from handoffs instead of lost context
- Users feel confident about maintenance without fear of data loss
