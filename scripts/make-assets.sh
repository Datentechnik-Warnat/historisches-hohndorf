#!/bin/bash



PUBLIC_DIR="public"
OUTPUT_FILE="public/assets.json"
TMP_JSON="$(mktemp)"

echo "[" > "$TMP_JSON"

first=true

# Alle HTML-Dateien durchlaufen
find "$PUBLIC_DIR" -name "*.html" -print0 | while IFS= read -r -d '' html_file; do
  # SHA256 Hash berechnen
  file_hash=$(sha256sum "$html_file" | awk '{ print $1 }')
  
  # Bild-URLs extrahieren (src="...") aus HTML
  asset_list=$(grep -oE 'src=["'"'"'][^"'"'"']+\.(jpg|jpeg|png|gif|svg|webp)(\?[^"'"'"']*)?["'"'"']' "$html_file" | \
    sed -E 's/^src=["'"'"'](.*)["'"'"']$$/\1/' | sort -u)

  # JSON-Array der Assets bauen
  assets_json="["
  while IFS= read -r line; do
    assets_json+="\"$line\","
  done <<< "$asset_list"
  assets_json="${assets_json%,}]"

  # Komma zwischen JSON-Objekten nur wenn nicht erstes Objekt
  if [ "$first" = true ]; then
    first=false
  else
    echo "," >> "$TMP_JSON"
  fi

  # JSON-Objekt für aktuelle Datei schreiben
  printf '  {\n    "file": "%s",\n    "hash": "%s",\n    "assets": %s\n  }' \
    "$html_file" "$file_hash" "$assets_json" >> "$TMP_JSON"
done

echo -e "\n]" >> "$TMP_JSON"
mv "$TMP_JSON" "$OUTPUT_FILE"

echo "✅ Assets und Datei-Hashes in ${OUTPUT_FILE} gespeichert."