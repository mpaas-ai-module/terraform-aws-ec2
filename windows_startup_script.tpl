<powershell>
# Change execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$ProgressPreference = 'SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
cd\
md temp
cd temp

# Download the package
Invoke-WebRequest -Uri https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.8.1-windows-x86_64.zip

# Restore the previous execution policy
Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope Process -Force

# Extract and install the package
Expand-Archive .\elastic-agent-8.8.1-windows-x86_64.zip -DestinationPath .
cd elastic-agent-8.8.1-windows-x86_64
.\elastic-agent.exe install --url=https://6d7f607d7dde4bebb494f4442612e81c.fleet.asia-south1.gcp.elastic-cloud.com:443 --enrollment-token=REDACTED --force --tag aws,windows
</powershell>