{{- define "base" -}}
{{- $global := required "Global Context ($ or .) should be specified in global" (index . "global") -}}
{{- $resourceType := required "Resource Name/Type should be specified in resourceType" (index . "resourceType") -}}
{{- $resourceSpec := required "Resource Spec Values should be specified in resourceSpec" (index . "resourceSpec") -}}
{{- $annotations := (index . "annotations") -}}
{{- $name := (index . "name" | default $global.Release.Name) -}}
{{- $acceptedResources := list "Service" "Ingress" -}}
{{- if not (has $resourceType $acceptedResources) -}}
{{- fail "Currently the K8S Resources supported are --> Service" -}}
{{- end -}}
apiVersion: {{ include "base.apiVersion" $resourceType }}
kind: {{ print $resourceType | quote }}
metadata: {{ include "objectMeta" (dict "global" $global "annotations" $annotations "name" $name) | nindent 2 }}
spec: {{ include (printf "%s.spec" ($resourceType | lower)) (dict "global" $global "spec" $resourceSpec) | nindent 2 }}
{{- end -}}

{{- define "base.apiVersion" -}}
{{- $v1Resources := list "Service" "ConfigMap" "Secret" -}}
{{- $networkingResources := list "Ingress" -}}
{{- if (has . $v1Resources) -}}
{{ print "v1" | quote }}
{{- else if (has . $networkingResources) -}}
{{ print "networking.k8s.io/v1" | quote }}
{{- end -}}
{{- end -}}