#!/bin/bash


# slidesディレクトリ内のすべての.mdファイルをループ処理
for file in slides/*.md; do
  filename=$(basename "$file" .md)
  output_dir="dist/$filename"
  
  # 出力ディレクトリを作成
  mkdir -p "$output_dir"
  
  # PDFの生成
  npx @marp-team/marp-cli@latest "$file" -o "$output_dir/output.pdf"
  
  # HTMLの生成
  npx @marp-team/marp-cli@latest "$file" -o "$output_dir/output.html"
done