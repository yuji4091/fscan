# Quick Start Prompts for Gemini AI Assistant

## Essential fscan Context (Copy this to Gemini)

```
You are now working with the fscan repository - a comprehensive internal network security scanning tool written in Go. Here's what you need to know immediately:

**What is fscan?**
- Internal network comprehensive scanning tool for security professionals
- Written in Go, designed for automated vulnerability assessment
- Supports host discovery, port scanning, service brute-forcing, and exploitation

**Architecture Overview:**
- main.go: Entry point
- Common/: Shared utilities (Types.go, Config.go, Flag.go, Log.go)
- Core/: Scanning engine (Scanner.go, PortScan.go, Registry.go)
- Plugins/: Service scanners (SSH, SMB, RDP, MySQL, Redis, etc.)
- WebScan/: Web application security scanning

**Key Features:**
1. Host discovery (ICMP) and port scanning
2. Service brute-forcing (SSH, SMB, databases)
3. Vulnerability detection (MS17-010, WebLogic, etc.)
4. Web fingerprinting and scanning
5. Exploitation capabilities (Redis, SSH command exec)

**Plugin System:**
- Each service has its own plugin in Plugins/
- Registered in Core/Registry.go
- Common interface: ScanPlugin struct with Name, Ports, Types, ScanFunc

**Build:** `go build -ldflags="-s -w" -trimpath main.go`

**Usage Examples:**
- Full scan: `./fscan -h 192.168.1.1/24`
- Specific ports: `./fscan -h 192.168.1.1 -p 80,443`
- SSH commands: `./fscan -h 192.168.1.1 -c "whoami"`

**IMPORTANT:** This is a security tool - only use on authorized systems. The tool is for legitimate security assessment and education.

Now you understand the fscan codebase structure and purpose. Ask me any specific questions about the implementation, features, or how to work with the code.
```

## For Deeper Technical Understanding

```
**fscan Technical Deep Dive:**

**Core Components Analysis:**
1. **Scanner Strategy Pattern** (Core/Scanner.go):
   - ServiceScanner: Standard service scanning
   - WebScanner: Web-focused scanning
   - LocalScanner: Local system scanning

2. **Plugin Architecture** (Common/Types.go):
   ```go
   type ScanPlugin struct {
       Name     string                // Plugin identifier
       Ports    []int                 // Supported ports
       Types    []string              // Categories (service/web/local)
       ScanFunc func(*HostInfo) error // Main function
   }
   ```

3. **Configuration System** (Common/Config.go):
   - Global settings, port definitions
   - Thread control, timeout settings
   - Output formatting options

4. **Logging and Output** (Common/Log.go, Output.go):
   - Multi-level logging (Debug, Info, Warning, Error)
   - Progress tracking with progress bars
   - Multiple output formats

**Key Scanning Workflows:**
1. Parse CLI arguments (Common/Flag.go)
2. Initialize scanner with strategy (Core/Scanner.go)
3. Discover hosts (Core/ICMP.go)
4. Scan ports (Core/PortScan.go)
5. Run service plugins (Plugins/)
6. Generate reports (Common/Output.go)

**Extension Points:**
- Add new service plugins in Plugins/
- Register in Core/Registry.go init()
- Follow existing patterns for error handling and logging
- Use TestDocker/ for testing new plugins

You now have deep technical insight into fscan's architecture and implementation patterns.
```

## For Web Scanning Context

```
**fscan Web Scanning Capabilities:**

**WebScan Module Structure:**
- WebScan/WebScan.go: Main coordinator
- WebScan/InfoScan.go: Information gathering
- WebScan/info/: Fingerprinting rules and signatures
- WebScan/lib/: Vulnerability detection library
- WebScan/pocs/: Proof-of-concept exploits

**Web Detection Features:**
1. **Fingerprinting** (WebScan/info/Rules.go):
   - CMS detection (WordPress, Drupal, etc.)
   - Framework identification (Laravel, Spring, etc.)
   - Technology stack analysis

2. **Vulnerability Scanning:**
   - WebLogic exploits
   - Struts2 vulnerabilities  
   - XRay POC integration
   - Custom web exploits

3. **Information Gathering:**
   - Title extraction
   - Technology headers
   - Response analysis
   - Directory enumeration

**POC System** (WebScan/lib/Check.go):
- CEL expression evaluation
- Parameter substitution
- Cluster testing support
- Response validation

This gives you complete understanding of fscan's web scanning architecture and capabilities.
```