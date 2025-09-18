#!/bin/bash

# 快速构建兼容Cursor的版本
echo "🚀 快速构建兼容Cursor的basedpyright扩展..."

# 1. 修改VSCode扩展的引擎版本
echo "🔧 修改引擎版本..."
sed -i 's/"vscode": "\^1\.101\.0"/"vscode": "^1.60.0"/' packages/vscode-pyright/package.json

# 2. 构建扩展
echo "🔨 构建扩展..."
cd packages/vscode-pyright
npm install

# 3. 直接使用vsce打包（跳过重命名步骤）
echo "📦 打包扩展..."
npx vsce package -o basedpyright-cursor.vsix

# 4. 检查结果
if [ -f "basedpyright-cursor.vsix" ]; then
    echo "✅ 成功生成: basedpyright-cursor.vsix"
    cp basedpyright-cursor.vsix ../..
    echo "📁 文件已复制到项目根目录"
else
    echo "❌ 打包失败"
fi

echo "🎉 完成！"