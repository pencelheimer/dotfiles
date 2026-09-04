;; extends

; Inject regex into the right side of PostgreSQL regex operators
(binary_expression
  operator: _ @operator
  right: (_) @injection.content
  (#any-of? @operator "~" "~*" "!~" "!~*")
  (#set! injection.language "regex"))
