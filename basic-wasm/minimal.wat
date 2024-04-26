(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func (export "main") (result i32)
		i32.const 1234123412
		call $log_i32
		i32.const 5
	)
)
