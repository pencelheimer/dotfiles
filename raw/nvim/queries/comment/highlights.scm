; -------------------------------------------------------------------------
; TODO level tags
; -------------------------------------------------------------------------
((tag
  (name) @comment.todo @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.todo "TODO" "TO-DO" "WIP"))

("text" @comment.todo @nospell
  (#any-of? @comment.todo "TODO" "TO-DO" "WIP"))

; -------------------------------------------------------------------------
; Note / Info level tags
; -------------------------------------------------------------------------
((tag
  (name) @comment.note @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.note "NOTE" "INFO" "DOCS" "PERF" "TEST" "HINT" "MARK" "PASSED" "STUB" "MOCK" "TIP" "OPTIMIZE" "PERFORMANCE" "QUESTION" "ASK"))

("text" @comment.note @nospell
  (#any-of? @comment.note "NOTE" "INFO" "DOCS" "PERF" "TEST" "HINT" "MARK" "PASSED" "STUB" "MOCK" "TIP" "OPTIMIZE" "PERFORMANCE" "QUESTION" "ASK"))

; -------------------------------------------------------------------------
; Warning level tags
; -------------------------------------------------------------------------
((tag
  (name) @comment.warning @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.warning "HACK" "WARN" "WARNING" "TEMP" "FIX"))

("text" @comment.warning @nospell
  (#any-of? @comment.warning "HACK" "WARN" "WARNING" "TEMP" "FIX"))

; -------------------------------------------------------------------------
; Error level tags
; -------------------------------------------------------------------------
((tag
  (name) @comment.error @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.error "BUG" "FIXME" "ERROR" "ISSUE" "XXX" "SAFETY" "FIXIT" "FAILED" "DEBUG" "INVARIANT" "COMPLIANCE" "PANIC"))

("text" @comment.error @nospell
  (#any-of? @comment.error "BUG" "FIXME" "ERROR" "ISSUE" "XXX" "SAFETY" "FIXIT" "FAILED" "DEBUG" "INVARIANT" "COMPLIANCE" "PANIC"))

; -------------------------------------------------------------------------
; Extras (Issues, Mentions, URLs)
; -------------------------------------------------------------------------
; Issue number (e.g., #123)
("text" @number
  (#lua-match? @number "^#[0-9]+$"))

; User mention (e.g., @username) - Kept from Helix!
("text" @constant
  (#lua-match? @constant "^@[%a%d_-]+$"))

; URLs - Using Neovim's modern standard
(uri) @markup.link.url @nospell
