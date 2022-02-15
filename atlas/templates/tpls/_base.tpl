{{- define "base" -}}
{{- $global := required "Global Context ($ or .) should be specified in global" (index . "global") -}}
{{- $resource := required "Resource should be specified in resource" (index . "resource") -}}
{{- if not (has $resource (list "Service")) -}}
{{- fail "Currently the K8S Resources supported are --> Service" -}}
{{- end -}}
{{- if (has $resource (list "Service" "ConfigMap" "Secret")) -}}
apiVersion: {{ print "v1" | quote }}
{{- end }}
kind: {{ print $resource | quote }}
metadata: {{ include "objectMeta" (dict "global" $global "annotations" $global.Values.service.annotations) | nindent 2 }}
spec: {{ include (printf "%s.spec" ($resource | lower)) (dict "global" $global "service" $global.Values.service) | nindent 2 }}
{{- end -}}