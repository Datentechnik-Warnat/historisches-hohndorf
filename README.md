## Theme

https://themes.gohugo.io/themes/hugo-flex/

## Im Content

### Bilder

https://gohugo.io/content-management/image-processing/

#### Bild rund mit Verlauf

```
{{% image-shape align="right" src="images/img_01.jpg" width="200" %}}
```
#### Bild
```
{{< image src="images/1913-2.jpg" title="Zeitungsanzeige aus dem Jahr 1913" alt="Zeitungsanzeige aus dem Jahr 1913" width="640" margin-top="10" >}}
```

## In Template / Shortcodes

### Verarbeitetes Bild
```
{{ $image := .Resources.Get "sunimages/img_01.jpg" }}
{{ with $image }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}">
{{ end }}
```
### Möglichkeiten der Bearbeitung

```
{{/* Resize to a width of 600px and preserve aspect ratio */}}
{{ $image := $image.Resize "600x" }}

{{/* Resize to a height of 400px and preserve aspect ratio */}}
{{ $image := $image.Resize "x400" }}

{{/* Resize to a width of 600px and a height of 400px */}}
{{ $image := $image.Resize "600x400" }}

{{ $image := $image.Process "crop 600x400" }}
{{ $image := $image.Process "fit 600x400" }}
{{ $image := $image.Process "fill 600x400" }}
```