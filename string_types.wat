(module
	(func $ref_add (import "imports" "add") (param externref externref) (result externref))
	(func (export "main") (result stringref)
		(local $result externref)
		ref.null extern
		drop
		string.const "Hello, world"
	)
)
