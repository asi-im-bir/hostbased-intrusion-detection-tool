---
flowchart TD

%% ================================
%% HIDS-Toolkit - System Logic Diagram
%% ================================

subgraph CRON[⏱️ Scheduler (Cron / CI)]
    A1["*/5 * * * * main_monitor.sh"]
end

subgraph MAIN[🧠 main_monitor.sh (Core Controller)]
    A2[Load Config (thresholds.conf, hids.conf)]
    A3{Baseline Exists?}
    A4[Initialize Baselines]
    A5[Execute Modules Sequentially]
    A6[Aggregate & Write Report]
    A7{Critical Alerts Found?}
    A8[Trigger email_alert.sh (Disabled in public)]
    A9[Append Logs → reports/system_scan_DATE.log]
end

subgraph MODULES[🔧 Monitoring Modules]
    M1[10_fim.sh – File Integrity]
    M2[20_users.sh – User/Group Audit]
    M3[30_resource_monitor.sh – CPU, RAM, Disk]
    M4[40_process_network.sh – Processes & Ports]
    M5[50_log_monitor.sh – Log-based Detection]
    M6[60_forensic.sh – Forensic Correlation]
end

subgraph STORAGE[💾 Data & Reports]
    S1[(db/file_hashes.baseline)]
    S2[(db/passwd.baseline)]
    S3[(reports/system_scan_YYYY-MM-DD.log)]
end

subgraph ALERTS[🚨 Alerts & Response]
    A10["Email / Notification (optional)"]
    A11["Security Engineer Review / SIEM Ingestion"]
end

%% --- Workflow Connections ---
CRON --> MAIN
A2 --> A3
A3 -- "No" --> A4
A3 -- "Yes" --> A5
A4 --> A5

A5 --> M1 & M2 & M3 & M4 & M5 & M6
M1 & M2 & M3 & M4 & M5 & M6 --> A6
A6 --> S3
A6 --> A7
A7 -- "Yes" --> A8 --> A10 --> A11
A7 -- "No" --> A9
A9 --> S3

%% --- Data Flow to Storage ---
M1 --> S1
M2 --> S2
S1 & S2 --> A5

---
