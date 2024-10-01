;; extends

(qualified_identifier
 name: (template_type
         arguments: (_) @type.inner )) @type.outer

(qualified_identifier
  name: (qualified_identifier
          scope: (template_type
                   arguments: (_) @template.inner))) @template.outer
