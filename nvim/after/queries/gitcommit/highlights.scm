; extends

((comment) @keyword
           (#match? @keyword "^# Parent: [0-9a-f]{8} .*$")
           (#offset! @keyword 0 2 0 0))

((comment) @constant
           (#match? @constant "^# Parent: [0-9a-f]{8} .*$")
           (#offset! @constant 0 10 0 0))

((comment) @string
           (#match? @string "^# Parent: [0-9a-f]{8} .*$")
           (#offset! @string 0 19 0 0))
