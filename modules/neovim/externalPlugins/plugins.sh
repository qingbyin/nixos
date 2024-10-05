#!/bin/bash
# 用于装一些nix不好管理的包（安装后需要修改的），比如 bracey 需要安装后运行npm install

# 插件列表
plugins=(
  "https://gh-proxy.com/github.com/turbio/bracey.vim" # 需进入目录运行`npm install --prefix server`
)

# 插件安装目录
install_dir="$HOME/.local/share/nvim/site/pack/localpkg/start"

# 创建插件目录（如果不存在）
mkdir -p "$install_dir"

# 下载每个插件
# for plugin in "${plugins[@]}"; do
#   git clone "$plugin" "$install_dir/$(basename "$plugin" .git)"
# done
for plugin in "${plugins[@]}"; do
  # 提取插件名称
  plugin_name=$(basename "$plugin" .git)
  
  # 检查插件是否已存在
  if [ -d "$install_dir/$plugin_name" ]; then
    echo "插件 '$plugin_name' 已存在，跳过下载。"
  else
    echo "下载插件 '$plugin_name'..."
    git clone "$plugin" "$install_dir/$plugin_name"
  fi
done
