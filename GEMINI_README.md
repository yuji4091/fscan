# 新助手 Gemini 快速入门指南

## 欢迎了解 fscan 项目！

这是一个用 Go 语言编写的内网综合扫描工具，用于安全专业人员进行自动化漏洞评估和网络侦察。

## 🚀 快速开始

### 第一步：复制这段话给 Gemini

```
你现在正在使用 fscan 仓库 - 这是一个用 Go 编写的综合内网安全扫描工具。

**fscan 是什么？**
- 内网综合扫描工具，专为安全专业人员设计
- 支持主机发现、端口扫描、服务爆破、漏洞利用
- 一键自动化安全评估和网络侦察

**架构概览：**
- main.go: 程序入口
- Common/: 共享工具库 (Types.go, Config.go, Flag.go 等)
- Core/: 扫描引擎 (Scanner.go, PortScan.go, Registry.go)
- Plugins/: 服务扫描器 (SSH, SMB, RDP, MySQL, Redis 等)
- WebScan/: Web 应用安全扫描

**主要功能：**
1. 主机发现 (ICMP) 和端口扫描
2. 服务爆破 (SSH, SMB, 数据库等)
3. 漏洞检测 (MS17-010, WebLogic 等)
4. Web 指纹识别和扫描
5. 漏洞利用 (Redis, SSH 命令执行)

**编译：** `go build -ldflags="-s -w" -trimpath main.go`

**使用示例：**
- 全扫描: `./fscan -h 192.168.1.1/24`
- 指定端口: `./fscan -h 192.168.1.1 -p 80,443`
- SSH 命令: `./fscan -h 192.168.1.1 -c "whoami"`

**重要提醒：** 这是安全工具 - 仅在授权系统上使用，用于合法安全评估和教育。

现在你理解了 fscan 代码库结构和用途。可以询问我任何关于实现、功能或如何使用代码的具体问题。
```

### 第二步：深入了解

根据你的具体需求，可以查看：

1. **QUICK_GEMINI_PROMPTS.md** - 简洁实用的提示词
2. **GEMINI_PROMPTS.md** - 详细全面的提示词
3. **GEMINI_EXAMPLES.md** - 问答示例，展示预期的理解水平

### 第三步：开始工作

将相关提示词复制给 Gemini，然后就可以开始询问具体的技术问题了！

## 📋 主要文件说明

- **GEMINI_PROMPTS.md**: 包含 5 个详细的提示词段落，涵盖项目概览、架构、功能、开发和安全考虑
- **QUICK_GEMINI_PROMPTS.md**: 3 个简洁的提示词，可直接复制使用
- **GEMINI_EXAMPLES.md**: 展示 Gemini 应该如何理解代码库的示例

## ✅ 使用提示

1. 根据你的需求选择合适的提示词
2. 复制给 Gemini 并等待确认理解
3. 开始询问具体的技术问题
4. 期待得到展示深度理解的回答

Gemini 应该能够理解 fscan 的架构、设计模式和最佳实践，并能帮助你进行代码开发、调试和扩展。