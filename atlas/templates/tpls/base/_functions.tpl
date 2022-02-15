{{- define "base" -}}
{{- $global := required "Global Context ($ or .) should be specified in global" (index . "global") -}}
{{- $resourceType := required "Resource Name/Type should be specified in resourceType" (index . "resourceType") -}}
{{- $resourceSpec := required "Resource Spec Values should be specified in resourceSpec" (index . "resourceSpec") -}}
{{- $acceptedResources := list "Service" -}}
{{- $v1Resources := list "Service" "ConfigMap" "Secret" -}}
{{- if not (has $resourceType $acceptedResources) -}}
{{- fail "Currently the K8S Resources supported are --> Service" -}}
{{- end -}}
{{- if (has $resourceType $v1Resources) -}}
apiVersion: {{ print "v1" | quote }}
{{- end }}
kind: {{ print $resourceType | quote }}
metadata: {{ include "objectMeta" (dict "global" $global "annotations" $global.Values.service.annotations) | nindent 2 }}
spec: {{ include (printf "%s.spec" ($resourceType | lower)) (dict "global" $global "spec" $resourceSpec) | nindent 2 }}
{{- end -}}