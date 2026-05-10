;; extends

; Inject Bash into double-quoted strings with '$', for env-vars highlighting
((string) @injection.content
 (#lua-match? @injection.content "%$")
 (#set! injection.language "bash"))
