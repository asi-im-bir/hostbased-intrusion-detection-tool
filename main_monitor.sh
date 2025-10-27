#!/usr/bin/env bash
# ===============================================================
# main_monitor.sh — Academic-aligned, safe public version
# Resource Guardians: Host-based Intrusion Detection Toolkit (HIDS)
# ===============================================================
# Author(s): Yuri, Sylvester, Patrick, Asiye
# Purpose: Central controller for all monitoring modules.
# Modes:
#   init  - initialize baselines (for file integrity, user auditing, etc.)
#   check - perform a full system scan using all modules
# ===============================================================

set -euo pipefail

# ----------[ Global Variables ]----------
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$BASE_DIR/modules"
CONFIG_DIR="$BASE_DIR/config"
REPORTS_DIR="$BASE_DIR/reports"
DB_DIR="$BASE_DIR/db"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
REPORT_FILE="$REPORTS_DIR/system_scan_$(date '+%Y-%m-%d').log"

# ----------[ Initialize Environment ]----------
mkdir -p "$REPORTS_DIR" "$DB_DIR"

# ----------[ Load Configuration ]----------
# These configs define system thresholds, allowed ports, and directories.
THRESHOLDS_CONF="$CONFIG_DIR/thresholds.conf"
HIDS_CONF="$CONFIG_DIR/hids.conf"

if [ ! -f "$THRESHOLDS_CONF" ] || [ ! -f "$HIDS_CONF" ]; then
  echo "[ERROR] Missing required configuration files in config/."
  echo "Please ensure thresholds.conf and hids.conf are configured."
  exit 1
fi

# ----------[ Utility Functions ]----------
timestamp() { date '+%Y-%m-%d %H:%M:%S'; }

log() {
  local level="$1"; shift
  echo "[$(timestamp)] [$level] $*" | tee -a "$REPORT_FILE"
}

run_module() {
  local module="$1"
  local action="$2"  # e.g., init or check
  if [ ! -x "$module" ]; then
    log "WARN" "Module $(basename "$module") not executable — using bash."
    bash "$module" "$action" --test 2>&1 | tee -a "$REPORT_FILE"
  else
    "$module" "$action" --test 2>&1 | tee -a "$REPORT_FILE"
  fi
}

# ----------[ Phase: INIT ]----------
initialize_system() {
  log "INFO" "===== HIDS Initialization Started ====="

  # Initialize FIM baseline if missing
  if [ ! -f "$DB_DIR/file_hashes.baseline" ]; then
    log "INFO" "No file integrity baseline found. Initializing..."
    [ -f "$MODULES_DIR/10_fim.sh" ] && run_module "$MODULES_DIR/10_fim.sh" init
  else
    log "INFO" "File integrity baseline already exists. Skipping init."
  fi

  # Initialize user/group baselines
  if [ ! -f "$DB_DIR/passwd.baseline" ]; then
    log "INFO" "No user/group baseline found. Initializing..."
    [ -f "$MODULES_DIR/20_users.sh" ] && run_module "$MODULES_DIR/20_users.sh" init
  else
    log "INFO" "User/group baseline already exists. Skipping init."
  fi

  log "INFO" "Initialization complete. Baselines ready for monitoring."
}

# ----------[ Phase: CHECK ]----------
perform_check() {
  log "INFO" "===== HIDS Security Scan Started at $TIMESTAMP ====="
  log "INFO" "Executing all security modules sequentially..."

  # Verify baselines exist before checks
  if [ ! -f "$DB_DIR/file_hashes.baseline" ]; then
    log "WARN" "FIM baseline missing — initializing automatically..."
    run_module "$MODULES_DIR/10_fim.sh" init
  fi

  if [ ! -f "$DB_DIR/passwd.baseline" ]; then
    log "WARN" "User baseline missing — initializing automatically..."
    run_module "$MODULES_DIR/20_users.sh" init
  fi

  # Run all modules in logical order (as documented)
  for module in "$MODULES_DIR"/*.sh; do
    case "$(basename "$module")" in
      10_fim.sh)              log "INFO" "Running File Integrity Monitoring...";;
      20_users.sh)            log "INFO" "Running User & Group Audit...";;
      30_resource_monitor.sh) log "INFO" "Running System Resource Checks...";;
      40_process_network.sh)  log "INFO" "Running Process & Network Analysis...";;
      50_log_monitor.sh)      log "INFO" "Running Log-based Intrusion Detection...";;
      60_forensic.sh)         log "INFO" "Running Forensic Log Analysis...";;
      *)                      log "INFO" "Running additional module: $(basename "$module")";;
    esac
    run_module "$module" check
  done

  log "INFO" "===== Security Scan Completed ====="

  # Optional: Detect critical issues and alert
  if grep -q "CRITICAL" "$REPORT_FILE"; then
    log "ALERT" "Critical issues detected (simulated)."
    log "INFO" "Email alerting disabled in public version for safety."
    # Uncomment for local private version:
    # "$BASE_DIR/email_alert.sh" --from-report "$REPORT_FILE"
  fi
}

# ----------[ HELP ]----------
show_help() {
  cat <<EOF
Usage: $0 {init|check}

Commands:
  init   Initialize all HIDS baselines (file integrity, user/group)
  check  Run full HIDS scan (all modules)
Examples:
  ./main_monitor.sh init
  ./main_monitor.sh check
EOF
}

# ----------[ Main Execution Flow ]----------
main() {
  case "${1:-}" in
    init)
      initialize_system
      ;;
    check)
      perform_check
      ;;
    *)
      show_help
      ;;
  esac
}

main "$@"
