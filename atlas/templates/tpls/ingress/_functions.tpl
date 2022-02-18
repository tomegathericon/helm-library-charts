{{- define "ingress.spec" -}}
{{- $name := required "Name of the Ingress is required to be passes in the name key" (index . "name") -}}
{{- $spec := required "Ingress Spec Values Should Be Specified in the spec key" (index . "spec") -}}
{{- with $spec -}}
{{- range $key, $value := .rules }}
{{- range $key, $value := . }}
backend: {{ include "ingress.backend" $value.service | nindent 2}}
{{- end }}
{{- end }}
{{- end -}}
{{- end -}}

{{- define "ingress.rule" -}}
{{- $acceptedPathTypes := list "ImplementationSpecific" "Exact" "Prefix" -}}
{{- $path := required "Path is mandatory for each paths item" .path -}}
{{- $pathType := .pathType | default "ImplementationSpecific"  -}}
{{- $backendService := required "Backend Service is required to be present" .service  -}}
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