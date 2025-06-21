{{/*
Define default redis_port
*/}}
{{- define "redis_bkp.port" -}}
{{- .Values.redis_port | default 6349 }}
{{- end }}

{{/*
Define header
*/}}
{{- define "redis_bkp.metadata" -}}
namespace: {{ .Release.Namespace }}
name: redis-{{ .Release.Name }}
labels:
  app: redis-{{ .Release.Name }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "redis_bkp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "redis_bkp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
