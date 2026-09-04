; Keywords
"include" @keyword.import
"profile" @keyword
"output" @keyword
"..." @keyword
"exec" @keyword
"alias" @keyword

; Directives and Option names
"mode" @keyword.directive
"position" @keyword.directive
"scale" @keyword.directive
"transform" @keyword.directive
"adaptive_sync" @keyword.directive
"preferred" @constant.builtin
"--custom" @attribute

(enable_disable) @keyword.type
(adaptive_sync_directive ["on" "off"] @boolean)

; Transform values (normal, flipped, 90, 180, 270, etc.)
(transform_value) @constant.builtin

; Punctuation & Delimiters
"{" @punctuation.bracket
"}" @punctuation.bracket
"," @punctuation.delimiter
"x" @punctuation.delimiter
"@" @punctuation.delimiter
"Hz" @keyword.unit

; Identifiers and Criteria
(alias_reference) @string.special.symbol
(alias_directive (alias_reference) @variable.readonly)
(output_criteria (identifier) @variable.parameter)
(output_criteria "*") @character.special
(profile_directive (identifier) @title)

; Numbers
(number) @number
(scale_directive (number) @number.float)
(coordinate (number) @number)
(mode_directive refresh_rate: (number) @number.float)

; Strings and Comments
(quoted_string) @string
(path) @string.special.path
(comment) @comment @spell
