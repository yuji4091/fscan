@echo off
REM Claude Code 全自动模式演示脚本

echo ============================================
echo   Claude Code 全自动模式演示

echo 步骤1: 检查配置文件
echo ============================================
if exist ".kilocodemodes" (
    echo ✓ 配置文件存在
) else (
    echo ✗ 配置文件不存在
)

if exist "claude-auto-prompt.md" (
    echo ✓ 提示词文件存在
) else (
    echo ✗ 提示词文件不存在
)

echo.
echo ============================================
echo 步骤2: 使用方法演示
echo ============================================
echo.
echo 方法1 - 直接使用提示词文件:
echo   claude --prompt-file claude-auto-prompt.md

echo 方法2 - Kilo Code模式切换:
echo   在VSCode中选择 "Claude Code 全自动模式（静音）"

echo 方法3 - 环境变量:
echo   set CLAUDE_SYSTEM_PROMPT=提示词内容
   claude

echo.
echo ============================================
echo 步骤3: 验证配置
echo ============================================
echo.
type .kilocodemodes | findstr "claude-auto"
if %errorlevel% equ 0 (
    echo ✓ 模式配置成功
) else (
    echo ✗ 模式配置失败
)

echo.
echo ============================================
echo 演示完成！
echo ============================================

echo 提示：重启VSCode后即可使用全自动模式
pause