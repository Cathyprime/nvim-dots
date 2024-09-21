; inherits: cpp

(preproc_def
  name: (identifier) @constant.macro)

(preproc_call
  directive: (preproc_directive)
  argument: (preproc_arg
              (translation_unit
                (expression_statement
                  (identifier) @function.macro))))
