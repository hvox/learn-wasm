(module
	(func $log (import "console" "log") (param i32))
	(func (export "main") (result i32)
		i32.const 42
		call $log
		i32.const 5
	)
)
