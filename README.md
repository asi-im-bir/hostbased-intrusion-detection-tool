# 🛡️ **HIDS-Toolkit — Linux Host-based Intrusion Detection System**

---

## 📘 **Overview**
**HIDS-Toolkit** is a Bash-based Host Intrusion Detection System (HIDS) simulation for Linux environments.  
It monitors, detects, and reports suspicious activity using only **native system tools**, demonstrating how host-based detection can be implemented without third-party dependencies.

This project showcases real-world cybersecurity concepts such as:
- Resource and system monitoring  
- File integrity verification  
- User auditing  
- Process and network inspection  
- Log-based threat detection  
- Automated alerting and forensics  

---

## 🎯 **Project Mission**
Develop a **modular, lightweight Linux HIDS** that performs:
- Continuous host monitoring  
- Anomaly detection  
- Forensic logging and alerting  

All powered by **Bash** and **cron automation**, using only built-in Linux utilities.

---

## 🧠 **Learning Goals**
This academic project was designed to strengthen:
- Advanced Linux administration and shell scripting  
- Modular Bash architecture design  
- Real-time log monitoring and alerting  
- Forensic correlation and reporting  
- Secure configuration management  
- Privacy-conscious system auditing  

---

## ⚙️ **Core Features**

| **Feature** | **Description** | **Tools Used** |
|--------------|-----------------|----------------|
| **System Resource Monitoring** | Monitors CPU, RAM, and Disk usage; alerts on threshold breaches | `uptime`, `free -m`, `df -h` |
| **File Integrity Monitoring (FIM)** | Detects unauthorized file changes using SHA256 hashing | `sha256sum`, `diff` |
| **User & Group Auditing** | Detects unauthorized user/group modifications | `awk`, `diff`, `/etc/passwd` |
| **Process & Network Scanning** | Flags suspicious processes and open ports | `ps aux`, `ss -tuln` |
| **Log-Based Detection** | Identifies brute-force, failed logins, root access, and sudo abuse | `grep`, `/var/log/auth.log`, `/var/log/syslog` |
| **Forensic Log Analysis** | Correlates events across multiple logs for investigations | `awk`, `grep`, `log_analyzer.sh` |
| **Automated Alerts** | Sends (or simulates) email alerts on critical findings | `email_alert.sh`, `ssmtp` |
| **Cron Automation** | Runs every 5 minutes for proactive detection | `cron`, `main_monitor.sh` |

---

## 🧭 **HIDS Toolkit — Architecture & Logic Overview**

### 🔧 **System Logic Diagram**
The diagram below illustrates the logical architecture of the HIDS Toolkit — how each component (cron, controller, modules, and storage) interact during system monitoring and alerting.

![HIDS Toolkit Logic Diagram](docs/logicoftoolkit.png)

---

### 🔄 **Execution Sequence Diagram**
This sequence diagram shows how the monitoring process flows:  
from cron scheduling → to `main_monitor.sh` → to the modules → and finally to reporting and alerting.

![HIDS Toolkit Sequence Diagram](docs/sequencediagram.png)

---

## 🚀 **Getting Started**

### 🧩 **1️⃣ Clone the Repository**
```bash
git clone https://github.com/<your-username>/hids-toolkit.git
cd hids-toolkit
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

## 🧠 **Future Application — Leveraging This Project in GRC, Audit, and Security Engineering**

This project is more than a technical demonstration — it provides a strong foundation for how I can apply **detection engineering**, **automation**, and **risk-based control validation** in professional environments.

---

### 🧩 **In GRC Engineering**

- **Control Implementation Evidence:**  
  Each detection script (e.g., file integrity, user auditing) can serve as technical proof that a control exists and operates effectively, aligning with **ISO 27001 A.12/A.16**, **CIS Control 4/5**, or **NIST 800-53 SI-4 (System Monitoring)**.  

- **Continuous Compliance Monitoring:**  
  By automating these checks through `cron`, the toolkit demonstrates how compliance evidence can be collected continuously — transforming static audits into ongoing assurance.  

- **Policy Enforcement:**  
  Bash-based checks can be tied to GRC platforms or compliance dashboards to validate adherence to security baselines and organizational standards.  

- **Audit-Ready Logging:**  
  Reports generated by the toolkit (e.g., user changes, file integrity results) mimic the type of timestamped, tamper-evident evidence auditors require for technical control reviews.  

- **Risk & Metrics Alignment:**  
  The alerting and threshold mechanisms model how technical indicators can be tied to **Key Risk Indicators (KRIs)** and **security metrics** in GRC reporting.  

---

### 🧭 **In Security Engineering**

- **Detection Engineering:**  
  Build custom detection logic for host-level threats, applying the same principles to enterprise tools like **Wazuh**, **Elastic Agent**, or **Splunk**.  

- **Endpoint Hardening:**  
  Extend file integrity and process auditing into production hardening frameworks and endpoint management policies.  

- **Security Automation:**  
  Integrate baseline checks into **CI/CD pipelines**, ensuring systems meet compliance controls before deployment.  

- **Incident Response:**  
  Use log correlation and forensic modules to support audit investigations and post-incident reviews.  

- **Alert Engineering:**  
  Convert findings into **SIEM-ready alerts**, providing visibility and measurable evidence of proactive defense.  

---

### 📋 **In IT Audit & Risk Assurance**

- **Evidence Collection Automation:**  
  Replace manual audit samples with automated data collection — every 5-minute scan acts as real-time control evidence.  

- **Audit Trail Integrity:**  
  The use of hashing (`sha256sum`) and timestamped logs models secure audit trail practices and non-repudiation.  

- **Control Effectiveness Validation:**  
  The toolkit provides a method to **test and verify** whether preventive and detective controls (e.g., password policy, unauthorized access alerts) are functioning as intended.  

- **Gap Analysis & Remediation:**  
  Findings from these scans can directly feed into risk registers and remediation plans during audit cycles.  

- **Integration with Governance Frameworks:**  
  The logic can be extended to support continuous control monitoring frameworks (CCM) or integrated GRC tools (e.g., ServiceNow GRC, Archer, or LogicGate).  

---

🧾 Source Code Availability

The complete codebase (all scripts and modules) is available on request for academic or professional review.
Only sanitized files and documentation are public for ethical and security reasons.


📨 Contact

GitHub: https://github.com/asi-im-bir

Project Type: Academic / Security Engineering Demonstration

✅ Summary Statement

HIDS-Toolkit demonstrates how native Linux tools can deliver real-time detection, forensic analysis, and compliance-aligned monitoring — bridging the gap between technical security engineering and GRC automation.

