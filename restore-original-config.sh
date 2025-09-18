#!/bin/bash

# 恢复原始的package.json配置

set -e

echo "🔄 恢复原始配置..."

# 检查备份文件是否存在
if [ ! -f "packages/vscode-pyright/package.json.backup" ]; then
    echo "❌ 错误: 未找到备份文件 packages/vscode-pyright/package.json.backup"
    exit 1
fi

# 恢复原始配置
cp packages/vscode-pyright/package.json.backup packages/vscode-pyright/package.json

echo "✅ 原始配置已恢复"

# 进入扩展目录清理依赖
cd packages/vscode-pyright

echo "🧹 清理node_modules..."
rm -rf node_modules package-lock.json

echo "📥 重新安装原始依赖..."
npm install

echo "🎉 恢复完成！"