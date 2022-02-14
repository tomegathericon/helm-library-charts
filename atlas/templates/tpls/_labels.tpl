{{- define "labels" -}}
{{- $environment := required "Environment Label should be specified in .Values.global.environment" ($.Values.global.environment) -}}
{{- $product := required "Product Label should be specified in .Values.global.product" ($.Values.global.product) -}}
{{- $service := required "Service Label should be specified in .Values.global.service" ($.Values.global.service) -}}
{{- $customLabels := $.Values.global.customLabels | default dict -}}
release: {{ print $.Release.Name | quote }}
heritage: {{ print $.Release.Service | quote }}
environment: {{ print $environment | quote }}
product: {{ print $product | quote }}
service: {{ print $service | quote }}
{{- if $customLabels }}
{{ toYaml $customLabels }}
{{- end -}}
{{- end -}}