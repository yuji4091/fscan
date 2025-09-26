# Gemini Understanding Examples

This file demonstrates how Gemini should understand and work with the fscan codebase after reading the prompts.

## Example 1: Understanding the Plugin System

**Question:** "How do I add a new service plugin to fscan?"

**Expected Gemini Response:**
```
To add a new service plugin to fscan, follow these steps:

1. **Create Plugin File** in `Plugins/` directory (e.g., `NewService.go`):
```go
package Plugins

import (
    "github.com/shadow1ng/fscan/Common"
)

func NewServiceScan(info *Common.HostInfo) error {
    // Implement your scanning logic here
    // Use Common.LogSuccess, Common.LogError for output
    return nil
}
```

2. **Register Plugin** in `Core/Registry.go` init() function:
```go
Common.RegisterPlugin("newservice", Common.ScanPlugin{
    Name:     "NewService",
    Ports:    []int{1234, 5678}, // Target ports
    ScanFunc: Plugins.NewServiceScan,
    Types:    []string{Common.PluginTypeService},
})
```

3. **Follow Patterns:**
- Use context for cancellation
- Respect thread limits (Common.ModuleThreadNum)
- Handle errors gracefully
- Use existing utilities from Plugins/Base.go

The plugin will automatically be available via `-m newservice` or run on matching ports during full scans.
```

## Example 2: Understanding Configuration

**Question:** "How does fscan handle command-line arguments and configuration?"

**Expected Gemini Response:**
```
fscan uses a multi-layered configuration system:

1. **Command-Line Parsing** (`Common/Flag.go`):
   - `Flag()` function handles CLI arguments
   - Environment variable support via `FS_ARGS`
   - Secure argument parsing with quotes support

2. **Global Configuration** (`Common/Config.go`):
   - Thread counts, timeouts, proxy settings
   - Port definitions and service mappings
   - Output formatting and logging levels

3. **Key Configuration Variables:**
   - `Common.Thread`: Concurrent scanning threads
   - `Common.Timeout`: Network operation timeouts
   - `Common.Ports`: Default port ranges
   - `Common.Proxy`: HTTP proxy settings

4. **Usage Pattern:**
```go
var Info Common.HostInfo
Common.Flag(&Info)           // Parse CLI args
err := Common.Parse(&Info)   // Validate and process
if err != nil {
    os.Exit(1)
}
```

The system prioritizes: CLI args > Environment vars > Defaults
```

## Example 3: Understanding Web Scanning

**Question:** "How does fscan's web vulnerability scanning work?"

**Expected Gemini Response:**
```
fscan's web scanning operates through several layers:

1. **Web Information Gathering** (`WebScan/InfoScan.go`):
   - HTTP title extraction
   - Technology fingerprinting
   - Framework detection

2. **Fingerprinting Engine** (`WebScan/info/Rules.go`):
   - Rule-based detection using headers, content, cookies
   - MD5-based file identification
   - Technology stack mapping

3. **Vulnerability Detection** (`WebScan/lib/Check.go`):
   - POC (Proof-of-Concept) execution
   - CEL expression evaluation for dynamic testing
   - Parameter substitution and cluster testing

4. **POC Structure Example:**
```yaml
name: weblogic-cve-2020-14882
rules:
  - method: POST
    path: /console/css/%252e%252e%252fconsole.portal
    headers:
      Content-Type: application/x-www-form-urlencoded
    body: "test=payload"
    expression: "status == 200 && contains(body, 'weblogic')"
```

5. **Integration Points:**
   - XRay POC compatibility
   - Custom exploit development
   - Automated vulnerability validation

The web scanner automatically runs during full scans or via `-m webscan`.
```

## Example 4: Understanding Architecture Patterns

**Question:** "What design patterns does fscan use and why?"

**Expected Gemini Response:**
```
fscan employs several key design patterns:

1. **Strategy Pattern** (`Core/Scanner.go`):
   - Different scanning strategies: ServiceScanner, WebScanner, LocalScanner
   - Allows runtime selection of scanning approach
   - Enables easy extension of scanning capabilities

2. **Plugin Architecture** (`Core/Registry.go`):
   - Modular design with independent service scanners
   - Registration-based system for dynamic plugin loading
   - Common interface for all scanning modules

3. **Factory Pattern** (`Core/Scanner.go`):
   - `NewScanner()` creates appropriate scanner type
   - Encapsulates scanner creation logic
   - Supports different scanning modes

4. **Command Pattern** (Throughout):
   - Each plugin encapsulates a scanning operation
   - Enables queuing and parallel execution
   - Supports undo/retry operations

5. **Observer Pattern** (Logging system):
   - Centralized logging with multiple outputs
   - Progress tracking and status updates
   - Event-driven result reporting

These patterns provide:
- **Modularity**: Easy to add new scanning capabilities
- **Maintainability**: Clear separation of concerns
- **Scalability**: Concurrent execution and resource management
- **Extensibility**: Plugin-based architecture for new features
```

## How to Use These Examples

1. **Copy the relevant prompt** from QUICK_GEMINI_PROMPTS.md
2. **Paste into Gemini** with your specific question
3. **Expect responses similar** to the examples above
4. **Follow up with specific** technical questions about implementation details

The key is that Gemini should demonstrate deep understanding of the codebase structure, patterns, and best practices when working with fscan.