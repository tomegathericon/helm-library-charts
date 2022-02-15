{{- define "objectMeta" -}}
{{- $global := required "Global Context ($ or .) should be specified in global" (index . "global") -}}
{{- $annotations := index . "annotations" -}}
{{- $name := index . "name" | default $global.Release.Name -}}
{{- $namespace := $global.Values.namespace.name | default $global.Release.Namespace -}}
{{- if $annotations -}}
annotations: {{ include "objectMeta.annotations" $annotations | nindent 2 }}
{{- end }}
labels: {{ include "objectMeta.labels" $global | nindent 2 }}
name: {{ print $name | quote }}
namespace: {{ $namespace | quote }}
{{- end -}}

{{- define "objectMeta.annotations" -}}
{{- if not (kindIs "map" .) -}}
{{- fail "Annotations must be specified as a map"  -}}
{{- end -}}
{{ toYaml . }}
{{- end -}}

{{- define "objectMeta.labels" -}}
{{- $environment := required "Environment Label should be specified in .Values.global.environment" .Values.global.environment -}}
{{- $product := required "Product Label should be specified in .Values.global.product" .Values.global.product -}}
{{- $service := required "Service Label should be specified in .Values.global.service" .Values.global.service -}}
{{- $customLabels := .Values.global.customLabels | default dict -}}
release: {{ print .Release.Name | quote }}
heritage: {{ print .Release.Service | quote }}
environment: {{ print $environment | quote }}
product: {{ print $product | quote }}
service: {{ print $service | quote }}
{{- if $customLabels }}
{{ toYaml $customLabels }}
{{- end -}}
{{- end -}}