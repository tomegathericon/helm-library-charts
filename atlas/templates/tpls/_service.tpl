{{- define "service.spec" -}}
{{- $global := required "Global Context ($ or .) Should Be Specified in the global key" (index . "global") -}}
{{- $service := required "Service Values Should Be Specified in the service key" (index . "service") -}}
{{- $ports := required "Ports should be defined in the service context" $service.ports -}}
{{- if not (kindIs "map" $service) -}}
{{- fail "Service should be of type map" -}}
{{- end -}}
{{- with $service -}}
{{- if .externalName }}
externalName: {{ print .externalName }}
{{- end }}
ports: {{ include "service.port" (dict "releaseName" $global.Release.Name "ports" $ports) | nindent 4 }}
{{- end -}}
{{- end -}}

{{- define "service.port" -}}
{{- $releaseName := required "Release Name is required to be passed on to the service.port function" (index . "releaseName") -}}
{{- $ports := (index . "ports") -}}
{{- if not (kindIs "map" $ports) -}}
{{- fail "Ports should be defined as a map" -}}
{{- end -}}
{{- range $key, $value := $ports }}
- name: {{- printf "%s-%s" $releaseName $key | lower | trunc 63 | quote -}}
{{- end -}}
{{- end -}}