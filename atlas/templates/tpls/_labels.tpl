{{- define "labels" -}}
{{- $global := index . "global" -}}
{{- $environment := index . "environment" | default $global.Values.global.environment -}}
{{- $product := index . "product" | default $global.Values.global.product -}}
{{- $service := index . "service" | default $global.Values.global.service -}}
{{- $customLabels := index . "customLabels" | default dict -}}
release: {{ print $global.Release.Name | quote }}
heritage: {{ print $global.Release.Service | quote }}
environment: {{ print $environment | quote }}
product: {{ print $product | quote }}
service: {{ print $service | quote }}
{{- if not (empty $customLabels) }}
{{ toYaml $customLabels }}
{{- end -}}
{{- end -}}