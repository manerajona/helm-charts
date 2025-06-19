{{- define "api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "api.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "api.config.yaml" -}}
redis_host: "{{ .Values.redis.host }}.{{ .Release.Namespace }}.svc.cluster.local"
redis_password: {{ .Values.redis.password | quote }}
app_port: 8000
app_listen: "0.0.0.0"
{{- end -}}
