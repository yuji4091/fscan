# Fscan Copilot 指令

## 架构概览

Fscan 是一个基于插件的网络扫描工具，使用 Go 语言编写，具有模块化架构：

- **Common 包**：核心工具、配置、日志、输出管理和全局状态
- **Core 包**：扫描编排、插件管理和策略模式
- **Plugins 包**：单个服务扫描器（SSH、SMB、数据库等）
- **WebScan 包**：Web 漏洞扫描，包含嵌入式 POC 框架

## 关键模式

### 插件注册系统
```go
// 在 Core/Registry.go init() 函数中注册插件
Common.RegisterPlugin("ssh", Common.ScanPlugin{
    Name:     "SSH",
    Ports:    []int{22, 2222},
    ScanFunc: Plugins.SshScan,
    Types:    []string{Common.PluginTypeService},
})
```

### HostInfo 结构体使用
```go
// 传递给所有插件的核心数据结构
type HostInfo struct {
    Host    string
    Ports   string
    Url     string
    Infostr []string
}
```

### 全局配置
通过 `Common.` 前缀的全局变量访问配置（例如：`Common.ThreadNum`、`Common.Timeout`）

## 关键工作流

### 构建
```bash
go build -ldflags="-s -w" -trimpath main.go
```

### 添加新插件
1. 在 `Plugins/` 目录中创建扫描函数
2. 在 `Core/Registry.go` init() 函数中注册插件
3. 遵循现有插件模式并正确处理错误

### 扫描模式
- **服务扫描**（默认）：网络服务枚举和暴力破解
- **Web 扫描**：基于 URL 的漏洞检测，使用嵌入式 POC
- **本地扫描**：系统信息收集

## 集成点

### Web POC 框架
- POC 嵌入在 `WebScan/pocs/` 目录中，作为 YAML 文件
- 通过 `embed.FS` 加载并由 `WebScan/lib` 包解析
- 兼容 Xray POC 格式

### 输出系统
- 多种格式：txt、json、csv
- 使用 `ScanResult` 类型结构化结果
- 线程安全的输出管理

### 外部依赖
- 服务扫描的数据库驱动
- Web 扫描的 HTTP 客户端
- 认证的 SSH/加密库

## 开发指南

### 错误处理
使用 `Common.LogError()` 处理失败，使用 `Common.LogSuccess()` 处理发现

### 日志级别
- `Common.LogDebug()`：开发细节
- `Common.LogBase()`：一般信息
- `Common.LogSuccess()`：积极发现
- `Common.LogError()`：错误和失败

### 线程处理
- 使用 `sync.WaitGroup` 和通道进行并发
- 遵守 `Common.ThreadNum` 和 `Common.Timeout` 设置
- 为长时间运行的操作实现上下文取消

### 测试
使用 `.github/workflows/` 中的 GitHub Actions 工作流运行构建
针对 `TestDocker/` 目录中的服务进行测试</content>
<parameter name="filePath">c:\Users\kench\OneDrive\Attachments\桌面\Ken-Lab\yuji4091-repositories\fscan\.github\copilot-instructions.md