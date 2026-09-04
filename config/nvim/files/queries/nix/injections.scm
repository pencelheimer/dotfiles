((comment) @injection.content
 (#set! injection.language "comment"))

; mark arbitrary languages with a comment
; #-style comments
((comment) @injection.language
  .
  [
    (string_expression (string_fragment) @injection.content)
    (indented_string_expression (string_fragment) @injection.content)
  ]
  (#gsub! @injection.language "#%s*([%w%p]+)%s*" "%1")
  (#set! injection.combined))

; /* */-style comments (optional)
((comment) @injection.language
  .
  [
    (string_expression (string_fragment) @injection.content)
    (indented_string_expression (string_fragment) @injection.content)
  ]
  (#gsub! @injection.language "/%*%s*([%w%p]+)%s*%*/" "%1")
  (#set! injection.combined))

; Common attribute keys corresponding to Python scripts,
; such as those for NixOS VM tests in nixpkgs/nixos/tests.
((binding
   attrpath: (attrpath (identifier) @_path)
   expression: (indented_string_expression
     (string_fragment) @injection.content))
 (#match? @_path "(^|\\.)testScript$")
 (#set! injection.language "python")
 (#set! injection.combined))

; Common attribute keys corresponding to scripts,
; such as those of stdenv.mkDerivation.
((binding
   attrpath: (attrpath (identifier) @_path)
   expression: [
     (indented_string_expression (string_fragment) @injection.content)
     (binary_expression (indented_string_expression (string_fragment) @injection.content))
   ])
 (#match? @_path "(^\\w*Phase|command|(pre|post)\\w*|(.*\\.)?\\w*([sS]cript|[hH]ook)|(.*\\.)?startup)$")
 (#set! injection.language "bash")
 (#set! injection.combined))

; builtins.{match,split} regex str
; Example: nix/tests/lang/eval-okay-regex-{match,split}.nix
((apply_expression
   function: (_) @_func
   argument: (indented_string_expression (string_fragment) @injection.content))
 (#match? @_func "(^|\\.)match|split$")
 (#set! injection.language "regex")
 (#set! injection.combined))

((apply_expression
   function: (apply_expression function: (_) @_func
     argument: (string_expression (string_fragment) @injection.filename))
   argument: (indented_string_expression (string_fragment) @injection.content))
 (#match? @_func "(^|\\.)write(Text|Script(Bin)?)$")
 (#set! injection.combined))

((indented_string_expression (string_fragment) @injection.shebang @injection.content)
  (#set! injection.combined))

; string contents of lib.literalExpression is nix code
((apply_expression
    function: [
      (select_expression) ; `lib.literalExpression`
      (variable_expression) ; `literalExpression` this is the case when the symbol is brougth into scope e.g. `let inherit (lib) literalExpression; in`
    ] @_func
    argument: [
      (indented_string_expression (string_fragment) @injection.content)  ; lib.literalExpression ''...''
      (string_expression (string_fragment) @injection.content) ; lib.literalExpression "..."
    ])
  (#any-of? @_func "lib.literalExpression" "literalExpression")
  (#set! injection.language "nix")
  (#set! injection.combined))
