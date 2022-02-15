{{- define "service.spec" -}}
{{- $global := required "Global Context ($ or .) Should Be Specified in the global key" (index . "global") -}}
{{- $spec := required "Service Spec Values Should Be Specified in the spec key" (index . "spec") -}}
{{- $ports := required "Ports should be defined in the service context" $spec.ports -}}
{{- $selectors := required "Selectors should be defined in the service context" $spec.selectors -}}
{{- $type := $spec.type | default "ClusterIP" -}}
{{- if not (kindIs "map" $spec) -}}
{{- fail "Service should be of type map" -}}
{{- end -}}
{{- with $spec -}}
{{- if .externalName }}
externalName: {{ print .externalName }}
{{- end }}
ports: {{ include "service.port" (dict "releaseName" $global.Release.Name "ports" $ports) | nindent 2 }}
selectors: {{ include "service.selectors" (dict "global" $global.Values.global "selectors" $selectors) | nindent 2 }}
type: {{ include "service.type" $type }}
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
{{- $selectors := (index . "selectors") -}}
{{- $environment := required "Environment Label should be specified in .Values.global.environment" ($global.environment) -}}
{{- $product := required "Product Label should be specified in .Values.global.product" ($global.product) -}}
{{- $spec := required "Service Label should be specified in .Values.global.service" ($global.service) -}}
environment: {{ print $environment | quote }}
product: {{ print $product | quote }}
service: {{ print $spec | quote }}
{{- if not (kindIs "map" $selectors) -}}
{{- fail "Selectors should be defined as a map" -}}
{{- end }}
{{ toYaml $selectors }}
{{- end -}}

{{- define "service.type" -}}
{{- if not (has . (list "ExternalName" "ClusterIP" "NodePort" "LoadBalancer")) -}}
{{- fail "Service Type should be either of ExternalName, ClusterIP, NodePort or LoadBalancer" -}}
{{- end -}}
{{ print . | quote }}
{{- end -}}