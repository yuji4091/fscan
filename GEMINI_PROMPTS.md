# Gemini AI Assistant Prompts for fscan Repository Understanding

Welcome to the fscan repository! This document contains comprehensive prompts to help you understand this codebase thoroughly. Please read through these sections carefully to gain deep insight into the project.

## 1. Project Overview Prompt

**Prompt:** "Please analyze the following information about fscan and provide a comprehensive understanding:

fscan is a comprehensive internal network scanning tool written in Go, designed for security professionals to perform automated vulnerability assessments and network reconnaissance. Here are the key points you need to understand:

### Core Purpose:
- **Primary Function**: Internal network comprehensive scanning tool for automated security assessments
- **Target Audience**: Security professionals, penetration testers, network administrators
- **Use Case**: One-click automation for comprehensive vulnerability scanning and network reconnaissance

### Main Capabilities:
1. **Information Gathering**: Host discovery via ICMP, comprehensive port scanning
2. **Brute Force Attacks**: Service password cracking (SSH, SMB, RDP, etc.) and database password attacks (MySQL, MSSQL, Redis, PostgreSQL, Oracle)
3. **System Information & Vulnerability Scanning**: NetBIOS detection, domain controller identification, network interface information collection, high-risk vulnerability detection (MS17-010, etc.)
4. **Web Application Detection**: Web title detection, web fingerprinting (CMS, OA frameworks), web vulnerability scanning (WebLogic, Struts2, supports XRay POC)
5. **Exploitation Modules**: Redis key injection and scheduled tasks, SSH command execution, MS17-010 exploitation with shellcode injection
6. **Auxiliary Features**: Comprehensive result storage and reporting

Based on this overview, you should understand that fscan is a powerful, multi-faceted security scanning tool with both reconnaissance and exploitation capabilities."

## 2. Architecture and Code Structure Prompt

**Prompt:** "Now let's examine the fscan codebase architecture. The project is organized into several key modules:

### Directory Structure:
```
/fscan/
├── main.go              # Entry point
├── Common/              # Shared utilities and types
├── Core/                # Core scanning engine and strategies
├── Plugins/             # Individual service scanning plugins
├── WebScan/             # Web application scanning modules
├── TestDocker/          # Docker test environments
├── image/               # Documentation images
└── go.mod/go.sum        # Go module dependencies
```

### Key Components Analysis:

#### 1. **Common Package** (Shared Infrastructure)
- `Types.go`: Core data structures (HostInfo, ScanPlugin)
- `Config.go`: Global configuration and port definitions
- `Flag.go`: Command-line argument parsing with environment variable support
- `Log.go`: Logging system with multiple levels
- `Output.go`: Result output management (file/console)
- `Parse*.go`: IP address and port parsing utilities
- `Proxy.go`: Proxy support for network scanning

#### 2. **Core Package** (Scanning Engine)
- `Scanner.go`: Main scanning strategy pattern implementation
- `PortScan.go`: Port scanning functionality
- `ServiceScanner.go`: Service-specific scanning logic
- `WebScanner.go`: Web application scanning coordination
- `ICMP.go`: Host discovery via ICMP
- `Registry.go`: Plugin registration and management system

#### 3. **Plugins Package** (Service Modules)
- Individual service scanners: SSH, SMB, RDP, MySQL, Redis, etc.
- `Base.go`: Common utilities for all plugins
- Exploitation modules: MS17010, various database exploits
- Each plugin follows a common interface pattern

#### 4. **WebScan Package** (Web Security)
- `WebScan.go`: Main web scanning coordinator
- `InfoScan.go`: Web information gathering
- `info/`: Web fingerprinting rules and signatures
- `lib/`: Web vulnerability detection library
- `pocs/`: Proof-of-concept exploits for web vulnerabilities

### Plugin Architecture:
The system uses a plugin-based architecture where each scanning module is registered with:
- **Name**: Plugin identifier
- **Ports**: Supported port ranges
- **Types**: Service categories (service/web/local)
- **ScanFunc**: Main scanning function

This modular design allows easy extension and maintenance of individual scanning capabilities."

## 3. Key Features and Functionality Prompt

**Prompt:** "Understanding fscan's key features and how they work together:

### 1. **Host Discovery and Port Scanning**
- **ICMP Discovery**: Uses raw sockets for efficient host discovery
- **Port Scanning**: Multi-threaded scanning with configurable thread counts
- **Service Detection**: Uses nmap service probes for accurate service identification
- **Custom Port Ranges**: Supports flexible port specification (-p parameter)

### 2. **Authentication and Brute Force**
- **Dictionary-based**: Uses built-in credential dictionaries
- **Protocol Support**: SSH, SMB, RDP, FTP, Telnet, and database protocols
- **Concurrent Processing**: Multi-threaded brute force with rate limiting
- **Success Detection**: Intelligent authentication success detection

### 3. **Vulnerability Detection**
- **MS17-010**: Complete SMB vulnerability detection and exploitation
- **Web Vulnerabilities**: WebLogic, Struts2, and XRay POC integration
- **Service Vulnerabilities**: Database misconfigurations, weak credentials
- **Custom POCs**: Extensible proof-of-concept framework

### 4. **Web Application Security**
- **Fingerprinting**: Comprehensive CMS and framework detection
- **Title Extraction**: Automated web page title collection
- **Technology Stack**: Framework and technology identification
- **Vulnerability Scanning**: Web-specific security assessments

### 5. **Exploitation Capabilities**
- **Redis Exploitation**: Public key injection and cron job creation
- **SSH Command Execution**: Remote command execution via SSH
- **Shellcode Injection**: Advanced exploitation with custom payloads
- **Persistence Mechanisms**: User creation and backdoor installation

### 6. **Output and Reporting**
- **Multiple Formats**: Console output, file logging, structured data
- **Progress Tracking**: Real-time progress bars and status updates
- **Detailed Logging**: Comprehensive logging with debug capabilities
- **Result Export**: Various output formats for further analysis

Understanding these features will help you work effectively with the codebase and understand how different modules interact."

## 4. Development and Usage Prompt

**Prompt:** "Here's how to work with fscan from both development and usage perspectives:

### Building and Development:
```bash
# Basic compilation
go build -ldflags="-s -w" -trimpath main.go

# With UPX compression (optional)
upx -9 fscan

# Development build with debug info
go build -v main.go
```

### Command Line Usage Examples:
```bash
# Full scan of a network range
./fscan -h 192.168.1.1/24

# Target specific ports
./fscan -h 192.168.1.1 -p 80,443,8080

# SSH command execution
./fscan -h 192.168.1.1 -c "whoami;id"

# Redis key injection
./fscan -h 192.168.1.1 -rf id_rsa.pub

# NetBIOS and domain detection
./fscan -h 192.168.1.1 -p 139 -m netbios

# Proxy support with XRay POCs
./fscan -h 192.168.1.1 -p 80 -proxy http://127.0.0.1:8080
```

### Key Configuration Points:
- **Thread Control**: `-t` parameter for thread count
- **Module Selection**: `-m` parameter for specific modules
- **Authentication**: `-user`/`-pwd` for credentials
- **Output Control**: Various output formatting options
- **Proxy Settings**: Built-in proxy support for web scanning

### Code Extension Guidelines:
1. **New Plugins**: Follow the ScanPlugin interface in Common/Types.go
2. **Registration**: Add to Core/Registry.go init() function
3. **Error Handling**: Use Common logging functions
4. **Concurrency**: Respect thread limits and use context for cancellation
5. **Testing**: Use TestDocker environments for validation

This information should give you a solid foundation for understanding, using, and potentially extending fscan's capabilities."

## 5. Security and Legal Considerations Prompt

**Prompt:** "Important security and legal aspects you must understand about fscan:

### Legal and Ethical Usage:
- **Authorization Required**: Only use on networks you own or have explicit permission to test
- **Educational Purpose**: Designed for legitimate security assessment and learning
- **No Malicious Intent**: Tool is for defensive security, not offensive attacks
- **Compliance**: Ensure usage complies with local laws and regulations

### Technical Security Considerations:
- **Rate Limiting**: Built-in protections to avoid overwhelming target systems
- **Stealth Options**: Configurable scanning speeds and techniques
- **Log Management**: Comprehensive logging for audit trails
- **Proxy Support**: Ability to route through proxies for additional privacy

### Responsible Development:
- **POC Only**: Vulnerability detection focuses on identification, not exploitation
- **Error Handling**: Robust error handling prevents unintended damage
- **Documentation**: Clear documentation of capabilities and limitations
- **Community Guidelines**: Follows responsible disclosure principles

Understanding these aspects is crucial for ethical and legal use of the tool."

## Summary

These prompts should give you a comprehensive understanding of:
1. What fscan is and its purpose
2. How the code is structured and organized
3. Key features and technical capabilities
4. How to build, use, and extend the tool
5. Important legal and security considerations

Take time to explore the codebase using this knowledge as your foundation. Focus on understanding the plugin architecture, scanning strategies, and how different modules work together to provide comprehensive security scanning capabilities.

Remember: This is a powerful security tool that should be used responsibly and only on systems you own or have explicit permission to test.