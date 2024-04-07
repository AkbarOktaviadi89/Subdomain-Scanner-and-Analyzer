#!/bin/bash

RED="\033[1;31m"
RESET="\033[0m"

# Define domain name from input
domain=$1

# Check if domain has been provided as an argument
if [ -z "$domain" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Create necessary sub-directories in the home directory
subdomain_path="$HOME/$domain/subdomains"
screenshot_path="$HOME/$domain/screenshots"
scan_path="$HOME/$domain/scans"

mkdir -p "$subdomain_path" "$screenshot_path" "$scan_path"

# Execute scanning tools
echo -e "${RED} [+] Launching Subfinder... ${RESET}"
subfinder -d "$domain" > "$subdomain_path/founds.txt"

echo -e "${RED} [+] Launching Assetfinder... ${RESET}"
assetfinder "$domain" | grep "$domain" >> "$subdomain_path/founds.txt"

echo -e "${RED} [+] Finding alive subdomains... ${RESET}"
cat "$subdomain_path/founds.txt" | grep "$domain" | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a "$subdomain_path/alive.txt"

echo -e "${RED} [+] Taking screenshots of alive subdomains... ${RESET}"
gowitness file -f "$subdomain_path/alive.txt" -P "$screenshot_path/" --no-http

echo -e "${RED} [+] Running Nmap on alive subdomains... ${RESET}"
nmap -iL "$subdomain_path/alive.txt" -T4 -p- -oN "$scan_path/nmap.txt"

echo -e "${RED} [+] Done.${RESET}"