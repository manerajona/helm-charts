{{/*
Return the release annotations given .Release
*/}}
{{- define "myConfigMaps.releaseAnnotations" -}}
releaseName: {{ .Release.Name }}
releaseVersion: {{ .Release.Revision | squote }}
{{- end }}

{{/*
Return the chart annotations given .Chart
*/}}
{{- define "myConfigMaps.chartAnnotations" -}}
chartVersion: {{ .Chart.Version | squote }}
{{- end }}

{{/*
Return author annotations given .Values.author
*/}}
{{- define "myConfigMaps.authorAnnotations" -}}
{{- with .Values.author }}
authorId: {{ randNumeric 6 | squote }}
authorUsername: {{ .fullName | camelcase }}
authorInitials: {{ .fullName | initials }}
authorFirstname: {{ .fullName | substr 0 8 }}
authorLastname: {{ .fullName | substr 9 -1 }}
authorFavouriteDisc: {{ repeat 3 "la " | title | quote }}
isAuthorJonathan: {{ .fullName | contains "Jonathan" | squote }}
{{- with .contact }}
authorEmail: {{ .email }}
authorPhone: {{ .phone }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Return the foo.txt file content
*/}}
{{- define "myConfigMaps.foo" -}}
{{ .Files.Get "files/foo.txt" }}
{{- end }}

{{/*
Return the bar.yml file config (asConfig)
*/}}
{{- define "myConfigMaps.bar" -}}
{{ (.Files.Glob "files/bar.yml").AsConfig }}
{{- end }}

{{/*
Return if "something" is "enabled" or "disabled"
*/}}
{{- define "myConfigMaps.isSomethingEnabled" -}}
{{- if .Values.somethingEnabled }}
something: "enabled"
{{- else }}
something: "disabled"
{{- end }}
{{- end }}

{{/*
Validates if v1 and v2 "match"
*/}}
{{- define "myConfigMaps.doV1andV2Match" -}}
{{- if and .Values.val1 .Values.val2 }}
valuesCheck: "match"
{{- else }}
valuesCheck: "no match"
{{- end }}
{{- end }}

{{/*
Validates if v3 and 3 "match"
*/}}
{{- define "myConfigMaps.isV3Eq3" -}}
{{- if eq .Values.val3 "3" }}
valuesCheck: "match"
{{- else }}
{{- fail "val3 is not valid" }}
{{- end }}
{{- end }}

{{/*
Returns myDefault value
*/}}
{{- define "myConfigMaps.myDefaultValue" -}}
myDefault: {{ default "default val" .Values.val4 }}
{{- end }}

{{/*
Return myRequired value
*/}}
{{- define "myConfigMaps.myRequiredValue" -}}
myRequired: {{ required "val5 cannot be empty" .Values.val5 | squote }}
{{- end }}