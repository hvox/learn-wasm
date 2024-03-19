(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func (export "main") (result i32)
		i32.const 2
		(if
			(then
				i32.const 321
				call $log_i32
			)
			(else
				i32.const 123
				call $log_i32
			)
		)
		i32.const 42
	)
)
