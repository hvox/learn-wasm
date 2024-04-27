(module
	(func $string.const (import "window" "s") (param i32 i32) (result externref))
	(func $log_externref (import "console" "log") (param externref))

	(memory $memory 1)
	(export "mem" (memory $memory))
	(data (i32.const 0) "Hello, world!")

	(func (export "main") (result)
		i32.const 0
		i32.const 13
		call $string.const
		call $log_externref
	)
)
