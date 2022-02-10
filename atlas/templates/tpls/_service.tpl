{{- define "service.spec" -}}
{{- $global := required "Global Context ($ or .) Should Be Specified in the global key" (index . "global") -}}
{{- $service := required "Service Values Should Be Specified in the service key" (index . "service") -}}
{{- if not (kindIs "map" $service) -}}
{{- fail "Service should be of type map" -}}
{{- end -}}
{{- with $service -}}
{{- if .allocateLoadBalancerNodePorts -}}
{{- if not (kindIs "bool" .allocateLoadBalancerNodePorts) -}}
{{- fail "allocateLoadBalancerNodePorts should be a boolean" -}}
{{- end -}}
allocateLoadBalancerNodePorts: {{ print .allocateLoadBalancerNodePorts }}
{{- end -}}
{{- if .clusterIP }}
clusterIP: {{ print .clusterIP }}
{{- end -}}
{{- if .clusterIPs -}}
{{- if not (kindIs "slice" .clusterIPs) -}}
{{- fail "clusterIPs should be a list" -}}
{{- end }}
clusterIPs: {{ toYaml .clusterIPs | nindent 4}}
{{- end -}}
{{- if .externalIPs -}}
{{- if not (kindIs "slice" .externalIPs) -}}
{{- fail "externalIPs should be a list" -}}
{{- end }}
externalIPs: {{ toYaml .externalIPs | nindent 4}}
{{- end -}}
{{- if .externalName }}
externalName: {{ print .externalName }}
{{- end -}}
{{- end -}}
{{- end -}}