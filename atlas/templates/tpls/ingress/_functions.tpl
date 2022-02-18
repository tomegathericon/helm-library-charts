{{- define "ingress.spec" -}}
{{/*- $name := required "Name of the Ingress is required to be passes in the name key" (index . "name") -*/}}
{{- $spec := required "Ingress Spec Values Should Be Specified in the spec key" (index . "spec") -}}
{{- with $spec -}}
{{- if .ingressClassName -}}
ingressClassName: {{ print .ingressClassName | quote }}
{{ end }}
rules: {{ include "ingress.rule" .rules | nindent 2 }}
{{- end -}}
{{- end -}}

{{- define "ingress.rule" -}}
{{- if not (kindIs "map" .) -}}
{{- fail "Ingress Rules must be specified as a map" -}}
{{- end -}}
{{- range $key, $value := . }}
- host: {{ print $key | quote }}
{{- if not (kindIs "slice" $value) -}}
{{- fail "Ingress Rule Values must be specifed as a list" $value -}}
{{- end }}
  http:
    paths:
{{- range $_, $value := $value -}}
{{ include "ingress.rule.value" $value | nindent 6 }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "ingress.rule.value" -}}
{{- $acceptedPathTypes := list "ImplementationSpecific" "Exact" "Prefix" -}}
{{- $path := required "Path is mandatory for each paths item" .path -}}
{{- $pathType := .pathType | default "ImplementationSpecific"  -}}
{{- $backendService := required "Backend Service is required to be present" .service  -}}
backend: {{ include "ingress.backend" $backendService | nindent 2 }}
path: {{ print $path | quote }}
pathType: {{ print $pathType | quote }}
{{- end -}}

{{- define "ingress.backend" -}}
{{- $name := required "Service Name is Required in the backend" .name -}}
{{- $port := required "Service Port is Required in the backend" .port -}}
service: 
  name: {{ print $name | quote }}
  port:
{{- if (kindIs "string" $port) }}
    name: {{ print $port | quote }}
{{- else }}
    number: {{ print $port | int }}
{{- end -}}
{{- end -}}