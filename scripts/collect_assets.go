package main

import (
	"crypto/sha256"
	"encoding/json"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	publicDir := "public"
	assets := make(map[string]string)

	err := filepath.Walk(publicDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err // Fehler beim Zugriff auf Datei
		}
		if info.IsDir() {
			return nil // Ordner ignorieren
		}

		// Datei öffnen
		file, err := os.Open(path)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Fehler beim Öffnen von %s: %v\n", path, err)
			return nil
		}
		defer file.Close()

		// SHA256 berechnen
		hasher := sha256.New()
		if _, err := io.Copy(hasher, file); err != nil {
			fmt.Fprintf(os.Stderr, "Fehler beim Lesen von %s: %v\n", path, err)
			return nil
		}
		hash := fmt.Sprintf("%x", hasher.Sum(nil))

		// Pfad relativ zu public/ und mit UNIX-Slashes
		relPath := strings.TrimPrefix(path, publicDir+"/")
		relPath = filepath.ToSlash(relPath)

		assets[relPath] = hash
		return nil
	})

	if err != nil {
		fmt.Fprintf(os.Stderr, "Fehler beim Durchsuchen von %s: %v\n", publicDir, err)
		os.Exit(1)
	}

	// JSON-Datei schreiben
	outfile, err := os.Create("public/assets.json")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Fehler beim Schreiben der assets.json: %v\n", err)
		os.Exit(1)
	}
	defer outfile.Close()

	encoder := json.NewEncoder(outfile)
	encoder.SetIndent("", "  ")
	if err := encoder.Encode(assets); err != nil {
		fmt.Fprintf(os.Stderr, "Fehler beim Codieren der JSON: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("✅ %d Dateien verarbeitet. assets.json wurde erstellt.\n", len(assets))
}