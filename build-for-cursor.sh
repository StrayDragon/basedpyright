#!/bin/bash

# 为Cursor编译基于pyright的扩展
# 只修改引擎版本要求，保持依赖不变

set -e

echo "🚀 为Cursor编译basedpyright扩展..."

# 检查是否在正确的目录
if [ ! -f "packages/vscode-pyright/package.json" ]; then
    echo "❌ 错误: 请在basedpyright根目录运行此脚本"
    exit 1
fi

# 临时修改VSCode引擎版本要求
echo "🔧 临时修改VSCode引擎版本要求..."
cd packages/vscode-pyright

# 备份原始package.json
cp package.json package.json.cursor-backup

# 使用sed修改引擎版本
sed -i 's/"vscode": "\^1\.101\.0"/"vscode": "^1.60.0"/g' package.json

echo "📦 安装依赖..."
npm install

echo "🔨 编译扩展..."
npm run clean
npm run webpack -- --mode production

echo "📦 打包扩展..."
npm run prepackage

# 查找生成的.vsix文件
VSIX_FILE=$(ls basedpyright-*.vsix 2>/dev/null | head -1)

# 恢复原始package.json
mv package.json.cursor-backup package.json

if [ -n "$VSIX_FILE" ]; then
    echo "✅ 编译成功！"
    echo "📁 生成的VSIX文件: $VSIX_FILE"
    echo ""
    echo "📋 安装说明:"
    echo "1. 在Cursor中打开命令面板 (Ctrl+Shift+P)"
    echo "2. 输入 'Extensions: Install from VSIX...'"
    echo "3. 选择文件: $(pwd)/$VSIX_FILE"
    echo "4. 重启Cursor"
    echo ""
    echo "⚠️  重要提示:"
    echo "- 如果安装时提示版本不兼容，请选择'仍要安装'"
    echo "- 安装后请在设置中禁用Pylance以避免冲突"
    echo "- 某些新功能可能在旧版本中不可用"

    # 将文件复制到项目根目录
    cp "$VSIX_FILE" ../..
    echo "📂 VSIX文件已复制到项目根目录: ../../$VSIX_FILE"
else
    echo "❌ 错误: 未找到生成的VSIX文件"
    exit 1
fi

echo ""
echo "🎉 完成！尝试在Cursor中安装扩展吧！"