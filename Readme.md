# Subdomain Scanner and Analyzer

This Bash script is designed to automate the process of subdomain enumeration, scanning, and analysis for a given domain. It utilizes popular tools like Subfinder, Assetfinder, httprobe, Gowitness, and Nmap to gather information about subdomains, take screenshots of live subdomains, and perform port scanning on them.

## Requirements

- Bash
- Subfinder
- httprobe
- Gowitness
- Nmap

## Usage

1. Clone the repository or download the script.
2. Make sure you have installed the required tools mentioned above.
3. Give execute permissions to the script: `chmod +x subdomain_scanner.sh`
4. Run the script with the domain you want to scan:

```bash
./subdomain_scanner.sh <domain>
