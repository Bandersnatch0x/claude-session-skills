# Claude Session Manager - Quick Start Guide

## ✅ Installation Complete!

**Claude Session Manager** 技能已成功创建在：
```
~/.claude/skills/claude-session-manager/
```

## 🚀 如何使用

### 方法 1：直接对话（推荐）

只需在 Claude Code 中说：

```
诊断我的 Claude Code 会话状态
```

或者：

```
帮我清理 Claude Code 的旧会话和工作区
```

或者：

```
为我当前的工作创建一个 handoff 文档
```

### 方法 2：运行诊断脚本

```bash
bash ~/.claude/skills/claude-session-manager/scripts/diagnose.sh
```

这将显示：
- 磁盘使用情况
- 会话统计
- 过期的 worktrees
- 可以清理的日志文件
- 推荐的清理操作

## 📋 典型使用流程

### 场景 1：定期维护

```
1. "运行会话诊断"
   → 查看当前状态和推荐操作
   
2. "为这个 API 重构工作创建 handoff"
   → 保存当前上下文供以后恢复
   
3. "执行安全清理：归档过期的 worktrees 和旧日志"
   → 清理不需要的文件
   
4. "验证清理结果"
   → 确认节省的空间和归档完整性
```

### 场景 2：快速清理

```
"清理 7 天以前的过期 worktrees"
```

### 场景 3：暂停工作前

```
"我要暂停 2 周，为当前的结账优化工作创建 handoff"
```

## 📁 技能结构

```
claude-session-manager/
├── SKILL.md                          # 主技能文件
├── README.md                         # 详细文档
├── QUICKSTART.md                     # 本文件
├── scripts/
│   └── diagnose.sh                   # 诊断脚本
└── references/
    ├── handoff-template.md           # Handoff 模板
    ├── maintenance-checklist.md      # 维护检查清单
    └── examples/
        ├── handoff-quality-example.md    # Handoff 示例
        └── typical-diagnosis.md          # 诊断报告示例
```

## 🔐 安全保证

此技能遵循严格的安全规则：

- ✅ **总是先诊断**（只读操作）
- ✅ **归档而非删除**（可恢复）
- ✅ **危险操作需要确认**
- ✅ **清理前自动备份**
- ❌ **永不触碰**：
  - 内存文件 (`~/.claude/projects/*/memory/`)
  - 技能和规则目录
  - 配置文件
  - 包含凭证的文件

## 🎯 常见任务

### 查看磁盘使用

```
显示 Claude Code 的磁盘使用情况
```

### 创建 Handoff

```
为我的认证系统重构工作创建 handoff 文档
```

### 清理过期 Worktrees

```
归档 7 天以前的 worktrees（无未提交更改）
```

### 压缩旧日志

```
压缩并归档 30 天以前的日志文件
```

### 完整维护

```
运行完整的会话维护：诊断、创建 handoffs、执行清理
```

## 💡 提示

1. **定期诊断**：每月运行一次诊断
2. **暂停前创建 handoff**：离开项目 >1 周时
3. **查看示例**：参考 `references/examples/` 了解最佳实践
4. **使用脚本**：`diagnose.sh` 可以快速了解状态

## 📖 更多信息

- 完整文档：`~/.claude/skills/claude-session-manager/README.md`
- Handoff 模板：`~/.claude/skills/claude-session-manager/references/handoff-template.md`
- 维护检查清单：`~/.claude/skills/claude-session-manager/references/maintenance-checklist.md`

## 🆘 需要帮助？

直接问我：

```
如何使用 claude-session-manager？
创建 handoff 的最佳实践是什么？
如何恢复归档的会话？
```

---

**版本:** 1.0.0  
**创建日期:** 2026-06-07  
**状态:** ✅ 已安装并可用
