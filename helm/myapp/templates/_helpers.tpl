{{- define "myapp.fullname" -}}
{{ .Chart.Name }}
{{- end -}}

{{- define "myapp.labels" -}}
app: {{ include "myapp.fullname" . }}
{{- end -}}