{{- define "service.spec" -}}
{{- $global := required "Global Context ($ or .) Should Be Specified in the global key" (index . "global") -}}
{{- $service := required "Service Values Should Be Specified in the service key" (index . "service") -}}
{{- $ports := required "Ports should be defined in the service context" $service.ports -}}
{{- $selectors := required "Selectors should be defined in the service context" $service.selectors -}}
{{- if not (kindIs "map" $service) -}}
{{- fail "Service should be of type map" -}}
{{- end -}}
{{- with $service -}}
{{- if .externalName }}
externalName: {{ print .externalName }}
{{- end }}
ports: {{ include "service.port" (dict "releaseName" $global.Release.Name "ports" $ports) | nindent 4 }}
selectors: {{ include "service.selectors" (dict "global" $global.Values "selectors" $selectors) | nindent 4 }}
{{- end -}}
{{- end -}}

{{- define "service.port" -}}
{{- $releaseName := required "Release Name is required to be passed on to the service.port function as releaseName" (index . "releaseName") -}}
{{- $ports := (index . "ports") -}}
{{- if not (kindIs "map" $ports) -}}
{{- fail "Ports should be defined as a map" -}}
{{- end -}}
{{- range $key, $value := $ports -}}
- name: {{ printf "%s-%s" $releaseName $key | lower | trunc 63 | quote }}
  port: {{ required "Each Element of the Port Array should have the port number specified as port" $value.port }}
  targetPort: {{ required "Each Element of the Port Array should have the target port number specified as targetPort" $value.targetPort }}
{{- if not (has $value.protocol (list "TCP" "UDP" "STCP")) -}}
{{- fail "Protocol should be either TCP, UDP or STCP" -}}
{{- end }}
  protocol: {{ print $value.protocol | quote }}  
{{ end -}}
{{- end -}}

{{- define "service.selectors" -}}
{{- $global := required ".Values.global is required to be passed in as global" (index . "global") -}}
{{- $environment := required "Environment Label should be specified in .Values.global.environment" ($global.environment) -}}
{{- $product := required "Product Label should be specified in .Values.global.product" ($global.product) -}}
{{- $service := required "Service Label should be specified in .Values.global.service" ($global.service) -}}
environment: {{ print $environment | quote }}
product: {{ print $product | quote }}
service: {{ print $service | quote }}
{{- if not (kindIs "map" .) -}}
{{- fail "Selectors should be defined as a map" -}}
{{- end }}
{{ toYaml . }}
{{- end -}}