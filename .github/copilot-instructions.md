# Fscan Copilot 指令

## 架构概览

Fscan 是一个基于插件的网络扫描工具，使用 Go 语言编写，具有模块化架构：

- **Common 包**：核心工具库（配置、日志、i18n、输出管理、全局状态和类型定义）
- **Core 包**：扫描编排引擎（策略模式、插件注册器、端口扫描、ICMP探测）
- **Plugins 包**：单个服务扫描器（40+ 插件：SSH、SMB、数据库、消息队列等）
- **WebScan 包**：Web 漏洞扫描引擎，包含嵌入式 POC 框架（200+ YAML POCs）
- **TestDocker**：测试环境容器配置（27 种服务用于插件验证）

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

### HostInfo 结构体 - 数据流核心
```go
// 传递给所有插件的核心数据结构 (Common/Types.go)
type HostInfo struct {
    Host    string   // 目标主机IP
    Ports   string   // 端口范围或列表
    Url     string   // Web扫描时的目标URL
    Infostr []string // 累积的扫描结果信息
}
```

### 策略模式扫描架构
```go
// Core/Scanner.go 中的策略选择
switch {
case Common.LocalMode:
    strategy = NewLocalScanStrategy()
case len(Common.URLs) > 0:
    strategy = NewWebScanStrategy()  
default:
    strategy = NewServiceScanStrategy()
}
```

### 全局配置系统
通过 `Common.` 前缀全局变量访问配置：
- `Common.ThreadNum` - 扫描线程数
- `Common.Timeout` - 连接超时
- `Common.LogLevel` - 日志级别
- `Common.PluginManager` - 插件注册表

## 关键工作流

### 构建和调试
```bash
# 标准构建（生产环境）
go build -ldflags="-s -w" -trimpath main.go

# 开发环境构建（保留符号表）
go build main.go

# 运行帮助查看所有选项
./main -h

# 测试本地扫描功能  
./main -local
```

### 插件开发流程
1. 在 `Plugins/` 创建扫描函数（如 `Plugins.NewServiceScan`）
2. 在 `Core/Registry.go` 的 `init()` 函数中注册：
   ```go
   Common.RegisterPlugin("service", Common.ScanPlugin{
       Name:     "ServiceName",
       Ports:    []int{port1, port2},
       ScanFunc: Plugins.NewServiceScan,
       Types:    []string{Common.PluginTypeService},
   })
   ```
3. 遵循错误处理模式：`Common.LogSuccess()` 用于发现，`Common.LogError()` 用于错误

### 扫描模式（通过策略模式选择）
- **服务扫描**（默认）：`./main -h 192.168.1.1` - 端口扫描 + 服务暴力破解
- **Web 扫描**：`./main -u http://target.com` - POC 漏洞检测
- **本地扫描**：`./main -local` - 系统信息收集和敏感文件发现

## 集成点

### Web POC 框架（WebScan/）
- **POC 存储**：`WebScan/pocs/` 目录中的 200+ YAML 文件（兼容 Xray 格式）
- **POC 加载**：通过 `embed.FS` 嵌入到二进制文件中
- **POC 引擎**：`WebScan/lib/` 包含解析器和执行引擎
- **POC 示例**：`weblogic-cve-2017-10271.yml`, `shiro-key.yml`

### 输出系统（Common/Config.go）
- **多格式支持**：txt、json、csv（通过 `-f` 参数）
- **结果结构**：使用 `ScanResult` 类型统一格式化
- **线程安全**：支持并发写入，自动锁机制
- **文件输出**：`-o result.txt` 指定输出文件

### 国际化支持（Common/i18n.go）
- **多语言**：中文（默认）、英文、日文、俄文
- **语言切换**：`-lang en` 切换到英文界面
- **消息模板**：所有用户可见文本都通过 `GetText()` 函数统一管理

### 外部依赖集成
- **数据库驱动**：MySQL, PostgreSQL, MongoDB, Redis 等
- **加密库**：SSH 连接、SSL/TLS 验证
- **网络库**：SMB、LDAP、SNMP 协议实现
- **压缩工具**：UPX 用于二进制文件压缩

## 开发指南

### 错误处理模式
```go
// 成功发现时使用
Common.LogSuccess(fmt.Sprintf("发现 %s 服务: %s", service, info))

// 错误或失败时使用  
Common.LogError(fmt.Sprintf("连接失败: %v", err))

// 调试信息使用
Common.LogDebug("详细调试信息")
```

### 日志级别系统
- `Common.LogDebug()`：开发调试详情（`-log DEBUG`）
- `Common.LogBase()`：基础信息输出（`-log INFO`）
- `Common.LogSuccess()`：成功发现（默认级别）
- `Common.LogError()`：错误和失败

### 并发处理模式
```go
// 标准并发模式
var wg sync.WaitGroup
ch := make(chan struct{}, Common.ThreadNum)

for _, target := range targets {
    wg.Add(1)
    ch <- struct{}{}
    go func(info Common.HostInfo) {
        defer func() { <-ch; wg.Done() }()
        // 扫描逻辑
    }(target)
}
wg.Wait()
```

### 命令行参数处理
- 环境变量支持：`FS_ARGS` 环境变量传递参数
- 远程参数解析：`FlagFromRemote()` 用于 API 模式
- 参数验证：通过 `Common.Parse()` 统一验证

### 测试和调试
- **测试容器**：`TestDocker/` 包含 27 种服务的容器配置
- **本地测试**：`./main -local` 测试本地信息收集
- **构建测试**：`.github/workflows/test-build.yml` 自动化构建验证
- **进度显示**：`-pg` 参数启用进度条，`-sp` 显示扫描计划</content>
<parameter name="filePath">c:\Users\kench\OneDrive\Attachments\桌面\Ken-Lab\yuji4091-repositories\fscan\.github\copilot-instructions.md