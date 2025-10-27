#!/usr/bin/env bash
# ===============================================================
# modules/30_resource_monitor.sh
# Part of: Resource Guardians – HIDS-Toolkit
# Author: Yuri (Resource Monitoring Lead)
# ===============================================================
# Purpose:
#   Monitors CPU load, memory, and disk usage.
#   Generates warnings if thresholds are exceeded.
#   All thresholds are loaded from config/thresholds.conf.
# ===============================================================
# Usage:
#   ./modules/30_resource_monitor.sh check
#   ./modules/30_resource_monitor.sh init
#   ./modules/30_resource_monitor.sh --test   (safe public demo mode)
# ===============================================================

set -euo pipefail

# ----------[ Global Setup ]----------
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$BASE_DIR/config"
REPORTS_DIR="$BASE_DIR/reports"
THRESHOLDS_CONF="$CONFIG_DIR/thresholds.conf"
REPORT_FILE="$REPORTS_DIR/sample_report.log"

mkdir -p "$REPORTS_DIR"

# Default thresholds (used if not set in config)
CPU_LOAD_THRESHOLD="2.0"
MEMORY_USAGE_THRESHOLD="90"
DISK_USAGE_THRESHOLD="90"

# ----------[ Load Configuration ]----------
if [ -f "$THRESHOLDS_CONF" ]; then
  # shellcheck source=/dev/null
  source "$THRESHOLDS_CONF"
fi

# ----------[ Utility Functions ]----------
timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

log() {
  local level="$1"; shift
  echo "[$(timestamp)] [$level] $*" | tee -a "$REPORT_FILE"
}

# ----------[ Monitoring Functions ]----------

check_cpu() {
  local load15
  load15=$(uptime | awk -F'load average:' '{print $2}' | awk -F',' '{print $3}' | tr -d ' ')
  local result
  result=$(awk -v load="$load15" -v thr="$CPU_LOAD_THRESHOLD" \
    'BEGIN { if (load+0 > thr+0) { print "CRITICAL"; } else { print "OK"; } }')

  if [[ "$result" == "CRITICAL" ]]; then
    log "CRITICAL" "CPU load average (15 min): ${load15} exceeds threshold ${CPU_LOAD_THRESHOLD}"
  else
    log "INFO" "CPU load average (15 min): ${load15} (normal)"
  fi
}

check_memory() {
  local total used used_pct
  read -r total used < <(free -m | awk '/Mem:/ {print $2" "$3}')
  used_pct=$(( used * 100 / total ))

  if (( used_pct >= MEMORY_USAGE_THRESHOLD )); then
    log "WARNING" "Memory usage ${used_pct}% exceeds threshold ${MEMORY_USAGE_THRESHOLD}%"
  else
    log "INFO" "Memory usage ${used_pct}% (normal)"
  fi
}

check_disk() {
  # Checks root partition usage only (safe for demo)
  local usep
  usep=$(df -h / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')
  if (( usep >= DISK_USAGE_THRESHOLD )); then
    log "WARNING" "Disk usage ${usep}% exceeds threshold ${DISK_USAGE_THRESHOLD}%"
  else
    log "INFO" "Disk usage ${usep}% (normal)"
  fi
}

# ----------[ Main Logic ]----------
main() {
  local action="${1:-check}"
  log "INFO" "===== Resource Monitor Started ($action) ====="

  case "$action" in
    init)
      log "INFO" "Initializing baseline for resource monitoring (none required)."
      ;;
    check|--test)
      check_cpu
      check_memory
      check_disk
      ;;
    *)
      log "ERROR" "Invalid action: $action"
      log "INFO" "Usage: $0 {init|check|--test}"
      exit 1
      ;;
  esac

  log "INFO" "===== Resource Monitor Completed ====="
  echo ""
}

main "$@"
