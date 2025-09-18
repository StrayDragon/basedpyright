#!/bin/bash

# 编译兼容Cursor版本的basedpyright VSCode扩展
# 此脚本将修改扩展的依赖版本以支持VSCode 1.60.0+ (包括Cursor 1.99.3)

set -e  # 遇到错误立即退出

echo "🚀 开始编译兼容Cursor版本的basedpyright扩展..."

# 检查是否在正确的目录
if [ ! -f "packages/vscode-pyright/package.json" ]; then
    echo "❌ 错误: 请在basedpyright根目录运行此脚本"
    exit 1
fi

# 备份原始package.json文件
echo "📦 备份原始配置文件..."
cp packages/vscode-pyright/package.json packages/vscode-pyright/package.json.backup

# 进入VSCode扩展目录
cd packages/vscode-pyright

echo "📥 安装兼容版本的依赖..."
npm install

echo "🔨 编译扩展..."
npm run clean
npm run webpack -- --mode production

echo "📦 打包扩展..."
npm run prepackage

# 查找生成的.vsix文件
VSIX_FILE=$(ls basedpyright-*.vsix 2>/dev/null | head -1)

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
    echo "🔧 注意: 安装后请在设置中禁用Pylance以避免冲突"

    # 将文件复制到项目根目录方便访问
    cp "$VSIX_FILE" ../..
    echo "📂 VSIX文件已复制到项目根目录: ../../$VSIX_FILE"
else
    echo "❌ 错误: 未找到生成的VSIX文件"
    exit 1
fi

echo ""
echo "🎉 完成！你可以在Cursor中安装并使用basedpyright了。"