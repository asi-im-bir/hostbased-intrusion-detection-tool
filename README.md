🛡️ HIDS-Toolkit — Linux Host-based Intrusion Detection System
🔧 Author: Resource Guardians

Team Members:

Yuri – Resource Monitoring & Team Lead

Sylvester – HIDS Framework & Security Modules

Patrick – Log & User Monitoring

Asiye – Integration, Automation & Documentation

📘 Overview

HIDS-Toolkit is a Bash-based Host Intrusion Detection System (HIDS) simulation for Linux environments.
It monitors, detects, and reports suspicious activity using only native system tools — showing how host-based detection can be implemented without third-party dependencies.

This project demonstrates real-world cybersecurity concepts such as resource tracking, file integrity monitoring, user auditing, process inspection, network analysis, and log-based threat detection — all automated through shell scripting.

🎯 Project Mission

Build a modular, lightweight Linux HIDS that performs continuous monitoring, detects anomalies, and sends alerts — using only native Bash utilities and cron automation.

🧠 Learning Goals

Developed as part of a cybersecurity learning initiative to demonstrate:

Advanced Linux administration and shell scripting

Modular Bash architecture design

Real-time log monitoring and alerting

Forensic log correlation and analysis

Automation using cron and email alerts

Secure and privacy-conscious system auditing

⚙️ Core Features
Feature	Description	Tools Used
System Resource Monitoring	Monitors CPU, RAM, Disk; alerts on threshold breaches	uptime, free -m, df -h
File Integrity Monitoring (FIM)	Detects unauthorized file changes via SHA256 hashing	sha256sum, diff
User & Group Auditing	Detects unauthorized user/group modifications	awk, diff, /etc/passwd
Process & Network Scanning	Flags suspicious processes and open ports	ps aux, ss -tuln
Log-Based Detection	Identifies brute-force, failed logins, root access, sudo abuse	grep, /var/log/auth.log, /var/log/syslog
Forensic Log Analysis	Correlates events across multiple logs for investigations	awk, grep, log_analyzer.sh
Automated Alerts	Sends (or simulates) email alerts on critical findings	email_alert.sh, ssmtp
Cron Automation	Scheduled every 5 minutes for proactive detection	cron, main_monitor.sh
📂 Repository Structure
hids-toolkit/
│
├── main_monitor.sh              # Central controller script
├── log_analyzer.sh              # Forensic analysis tool
├── email_alert.sh               # Email notification module
│
├── modules/                     # Modular components
│   ├── 10_fim.sh                # File Integrity Monitoring
│   ├── 20_users.sh              # User/Group Auditing
│   ├── 30_resource_monitor.sh   # Resource Monitoring (example)
│   ├── 40_process_network.sh    # Process & Network Monitoring
│
├── config/
│   ├── thresholds.conf          # Threshold limits
│   ├── hids.conf                # Monitored dirs & ports
│   ├── email.conf.example       # Sanitized email config
│
├── reports/
│   └── sample_report.log        # Example sanitized output
│
├── docs/
│   ├── INSTALLATION.md          # Setup guide
│   └── DESIGN_OVERVIEW.md       # Architecture explanation
│
├── .gitignore                   # Ignore sensitive/log files
└── LICENSE                      # MIT License

🚀 Getting Started

1️⃣ Clone the Repository

git clone https://github.com/<your-username>/hids-toolkit.git
cd hids-toolkit


2️⃣ Make Scripts Executable

chmod +x *.sh modules/*.sh


3️⃣ Configure Settings
Edit:

config/thresholds.conf – alert thresholds

config/hids.conf – directories and ports

config/email.conf – local alert email (use example template)

4️⃣ Run a Module Manually

./modules/30_resource_monitor.sh --test


5️⃣ Schedule via Cron (optional)

crontab -e
*/5 * * * * /full/path/to/main_monitor.sh >> /var/log/main_monitor_cron.log 2>&1

🧪 Example Report Output
===== Resource Monitor run at: 2025-10-27 09:30:00 =====
OK: CPU 15-min load 0.35
OK: Memory usage 45%
OK: Disk / usage 42%

===== HIDS Alerts Summary =====
[INFO] 2025-10-27 09:31:10 - 5 failed SSH login attempts from 192.168.1.25
[WARNING] 2025-10-27 09:32:12 - Unauthorized port open: 8081
[CRITICAL] 2025-10-27 09:33:20 - File integrity changed: /etc/sample.conf


(All data sanitized for privacy and demonstration purposes.)

🔒 Security & Privacy Notes

No real logs or credentials are included.

All IPs and usernames are anonymized.

Credentials should be stored using environment variables or secrets managers.

.gitignore ensures config/email.conf and live reports stay private.

🧩 Educational Value

This project demonstrates:

Host-based security monitoring using native Linux tools

Modular Bash scripting & automation design

Log correlation and forensic analysis principles

Alert automation and basic incident response simulation

Secure coding and configuration management awareness

🧠 Future Application — GRC & Security Engineering

This project laid the foundation for how I would apply my skills professionally in Governance, Risk, and Compliance (GRC) and Security Engineering:

🧩 In Security Engineering

Threat Detection & Response Design: I can build and tune detection logic for Linux servers, focusing on system behavior baselining and alert thresholds.

Endpoint Hardening & Monitoring: Apply FIM, process auditing, and log-based detection in enterprise host monitoring frameworks (e.g., Wazuh, OSSEC, or Elastic Agent).

Automation & DevSecOps: Integrate host-security checks into CI/CD or configuration-management pipelines.

Incident Response Support: Use similar scripts to extract forensic evidence or validate security baselines during investigations.

Alert Engineering: Translate findings into actionable events for SOC pipelines or SIEM ingestion.

🧭 In GRC / Risk Management

Control Validation: Map technical detections to frameworks like NIST 800-53, CIS Controls, and ISO 27001 Annex A (12, 13).

Compliance Automation: Adapt Bash checks to support evidence collection for compliance audits.

Policy-to-Control Mapping: Show how system-level detections align with defined organizational security controls.

Reporting & Metrics: Generate automated compliance status reports using sanitized system data.

💼 Long-Term Vision

This toolkit demonstrates my ability to bridge the gap between technical detection engineering and governance & compliance, translating operational security into measurable, reportable controls.

🧾 Source Code Availability

The complete codebase (all scripts and modules) is available on request for academic, evaluation, or professional review.
Please contact me directly for a private demonstration or code walkthrough.

⚠️ Only sanitized versions of configuration and report files are public for security reasons.

🪪 License

MIT License — Free to use and modify with attribution.

📨 Contact

Maintainer: <your_email@example.com>
GitHub: https://github.com/<your-username>

Project Type: Academic / Security Engineering Demonstration