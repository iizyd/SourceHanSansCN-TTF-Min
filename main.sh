#!/bin/bash

# 源字体根目录和目标输出根目录
SRC_ROOT="./src"
DIST_ROOT="./dist"

# 字符集文件路径
CONTENT_FILE="./content.txt"

# 获取 src 下的所有字体子目录（如 ttf, otf 等）
for dir in "$SRC_ROOT"/*/; do
    # 获取字体类型（如 ttf、otf）
    font_type=$(basename "$dir")

    # 构建对应的目标目录
    dist_dir="$DIST_ROOT/$font_type"

    # 创建目标目录（如果不存在）
    mkdir -p "$dist_dir"

    # 遍历当前字体类型目录下的所有字体文件
    for font_file in "$dir"/*.{ttf,otf}; do
        # 如果没有匹配到字体文件则跳过
        [ -e "$font_file" ] || continue

        # 获取字体文件名
        base_name=$(basename "$font_file")

        echo "正在压缩字体: $base_name ($font_type)"
        pyftsubset "$font_file" --text-file="$CONTENT_FILE" --output-file="$dist_dir/$base_name"
    done
done

echo "✅ 所有字体压缩完成，已保存至 dist 目录。"