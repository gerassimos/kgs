
{{/*
Selector labels
*/}}
{{- define "helm-basic-example.commonLabels" -}}
app.kubernetes.io/name: "helm-basic-example.name"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


