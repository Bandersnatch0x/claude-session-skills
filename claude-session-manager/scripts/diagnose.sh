#!/usr/bin/env bash
# Claude Code Session Diagnosis Script
# Usage: bash scripts/diagnose.sh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

print_safe() {
    echo -e "${GREEN}🟢 SAFE:${NC} $1"
}

print_caution() {
    echo -e "${YELLOW}🟡 CAUTION:${NC} $1"
}

print_danger() {
    echo -e "${RED}🔴 DANGEROUS:${NC} $1"
}

# Get human-readable size
human_size() {
    du -sh "$1" 2>/dev/null | cut -f1 || echo "0B"
}

# Main diagnosis
main() {
    echo -e "${BLUE}Claude Code Session Diagnosis${NC}"
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "================================================"

    # Check last cleanup
    print_header "Last Cleanup"
    if [ -f ~/.claude/.last-cleanup ]; then
        LAST_CLEANUP=$(cat ~/.claude/.last-cleanup)
        echo "Last cleanup: $LAST_CLEANUP"
    else
        echo "No cleanup record found"
    fi

    # Total disk usage
    print_header "Disk Usage"
    TOTAL_SIZE=$(human_size ~/.claude/)
    echo "Total Claude Code disk usage: $TOTAL_SIZE"

    # Top 10 largest directories
    echo -e "\nTop 10 largest directories:"
    du -h ~/.claude/ 2>/dev/null | sort -rh | head -10

    # Session statistics
    print_header "Session Statistics"
    if [ -f ~/.claude/.session-stats.json ]; then
        echo "Session stats file exists"
        cat ~/.claude/.session-stats.json | head -20
    else
        echo "No session stats found"
    fi

    # Active sessions
    if [ -d ~/.claude/context-mode/sessions ]; then
        SESSION_COUNT=$(find ~/.claude/context-mode/sessions -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
        echo "Active sessions: $SESSION_COUNT"
    else
        echo "No sessions directory found"
    fi

    # Worktree analysis
    print_header "Worktree Analysis"
    if [ -d ~/.claude/.claude/worktrees ]; then
        WORKTREE_COUNT=$(find ~/.claude/.claude/worktrees -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
        echo "Total worktrees: $WORKTREE_COUNT"

        # Stale worktrees (>7 days)
        echo -e "\nStale worktrees (>7 days old):"
        find ~/.claude/.claude/worktrees -mindepth 1 -maxdepth 1 -type d -mtime +7 2>/dev/null | while read -r wt; do
            SIZE=$(human_size "$wt")
            NAME=$(basename "$wt")
            print_safe "[$SIZE] $NAME"
        done
    else
        echo "No worktrees directory found"
    fi

    # Project analysis
    print_header "Project Statistics"
    if [ -d ~/.claude/projects ]; then
        PROJECT_COUNT=$(find ~/.claude/projects -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
        echo "Total projects: $PROJECT_COUNT"

        echo -e "\nTop 5 largest projects:"
        du -sh ~/.claude/projects/*/ 2>/dev/null | sort -rh | head -5
    else
        echo "No projects directory found"
    fi

    # Log file analysis
    print_header "Log File Analysis"
    LOG_COUNT=$(find ~/.claude/ -name "*.log" 2>/dev/null | wc -l)
    echo "Total log files: $LOG_COUNT"

    if [ $LOG_COUNT -gt 0 ]; then
        OLD_LOG_COUNT=$(find ~/.claude/ -name "*.log" -mtime +30 2>/dev/null | wc -l)
        echo "Logs older than 30 days: $OLD_LOG_COUNT"
    fi

    # Large files (>10MB)
    print_header "Large Files (>10MB)"
    LARGE_FILE_COUNT=$(find ~/.claude/ -type f -size +10M 2>/dev/null | wc -l)
    echo "Total files >10MB: $LARGE_FILE_COUNT"

    if [ $LARGE_FILE_COUNT -gt 0 ]; then
        echo -e "\nTop 5 largest files:"
        find ~/.claude/ -type f -size +10M -exec ls -lh {} \; 2>/dev/null | sort -k5 -rh | head -5
    fi

    # Recommendations
    print_header "Recommendations"
    echo -e "\nNext steps:"
    print_safe "Archive stale worktrees (>7 days, no uncommitted changes)"
    print_safe "Compress and archive logs >30 days old"
    print_caution "Create handoffs for important sessions before archiving"

    echo -e "\n${BLUE}================================================${NC}"
    echo "Diagnosis complete. Review findings above."
}

# Run diagnosis
main "$@"
