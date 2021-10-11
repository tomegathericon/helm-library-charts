{{- define "labels" -}}
{{- $global := required "Global Context should be specified in the 'global' key" (index . "global") -}}
{{- $environment := required "Environment Label should be specified in .Values.global.environment" ($global.Values.global.environment) -}}
{{- $product := required "Product Label should be specified in .Values.global.product" ($global.Values.global.product) -}}
{{- $service := required "Service Label should be specified in .Values.global.service" ($global.Values.global.service) -}}
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