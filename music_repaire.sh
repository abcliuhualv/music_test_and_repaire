csv_file="./audio_bad_20261011.csv"   # 替换为你的 CSV 文件路径

# 提取第一列（跳过表头行），逐行处理
awk -F',' 'NR>1 { print $1 }' "$csv_file" | while IFS= read -r file; do
    # echo "$file"                     # 输出第一列的值
    temp_file="${file}.tmp.flac"     # 拼接后缀
    # echo "$temp_file"                # 输出拼接后的文件名
	
	# ffmpeg -nostdin -y -i "$file" -map 0 -c:a flac -c:v copy "$temp_file"
	mv "$temp_file" "$file"
done