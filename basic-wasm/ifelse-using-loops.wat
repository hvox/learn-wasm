(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func (export "main") (result i32)
		(block $if_else_block
			(block $else
				i32.const 2
				br_if $else
				i32.const 123
				call $log_i32
				br $if_else_block
			)
			i32.const 321
			call $log_i32
		)
		i32.const 42
	)
)
