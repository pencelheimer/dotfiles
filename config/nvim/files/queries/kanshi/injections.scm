; Inject bash parser into exec commands
(exec_directive
  (command_text) @injection.content
  (#set! injection.language "bash"))

; Inject comment parser into comments (TODO, FIXME, etc.)
((comment) @injection.content
  (#set! injection.language "comment"))
