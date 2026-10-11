#!/usr/bin/env bash
MUSIC="/music/伍佰 专辑合集1992-2023"
OUT="/music/audio_bad_$(date +%Y%m%d).csv"
: > "$OUT"
printf 'path,error\n' > "$OUT"


find "$MUSIC" -type f \( \
  -iname '*.flac' -o -iname '*.mp3' -o -iname '*.ape' -o -iname '*.wav' \
  -o -iname '*.m4a' -o -iname '*.aac' -o -iname '*.ogg' -o -iname '*.opus' \
  \) -print0 | while IFS= read -r -d '' f; do
	err=$(ffmpeg -nostdin -v error -i "$f" -f null - 2>&1)
	if [ -n "$err" ];then
		# 去掉换行，写进 csv 一列
		err1=$(printf '%s' "$err" | tr '\n' ';')
		printf '%s,"%s"\n' "$f" "$err1" >> "$OUT"
		echo "BAD: $f -> $err1"
	fi
done
