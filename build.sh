#!/bin/bash


# index.htmlのヘッダーを追加
cat <<EOT > dist/index.html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Slides</title>
</head>
<body>
    <header>
        <h1>Slides</h1>
    </header>
    <main>
        <section>
            <ul>
EOT

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
  
  # index.htmlにリンクを追加
  echo "                <li>" >> dist/index.html
  echo "                    <span>$filename:</span>" >> dist/index.html
  echo "                    <ul>" >> dist/index.html
  echo "                        <li><a href=\"${output_dir#dist/}/output.html\">HTML</a></li>" >> dist/index.html
  echo "                        <li><a href=\"${output_dir#dist/}/output.pdf\">PDF</a></li>" >> dist/index.html
  echo "                    </ul>" >> dist/index.html
  echo "                </li>" >> dist/index.html
done

# index.htmlのフッターを追加
cat <<EOT >> dist/index.html
            </ul>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 nasjp</p>
    </footer>
</body>
</html>
EOT