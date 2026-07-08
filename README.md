# Automated Nginx Log Backup

A lightweight Bash script that automates Nginx log rotation and backup based on active storage usage.

---

## 🚀 Features
* **Smart Alert:** Triggers a backup only when log directory storage exceeds **85%**.
* **Zero Downtime:** Uses `truncate` to clear active logs safely without restarting Nginx.
* **Auto-Cleanup:** Deletes old backup archives after **10 days** to save disk space.
* **Root Security:** Restricts execution to the `root` user for safety.

---

## 🛠️ Built With
* **Language:** Bash Scripting
* **Utilities:** `df`, `tar`, `truncate`, `find`, `awk`, `sed`

---

## ⚙️ How to run it 24/7 (Automation Setup)
If you want this script to run automatically 24/7 every hour in the background, add this line to your system crontab:
```bash
0 * * * * /path/to/backup_logs.sh
