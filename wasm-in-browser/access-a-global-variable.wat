(module
	(func $string.const (import "window" "s") (param i32 i32) (result externref))
	(func $log (import "console" "log") (param i32))
	(func $log_externref (import "console" "log") (param externref))
	(func $eval_js (import "window" "eval") (param externref))
	(func $func.eval_js (import "window" "eval") (param externref) (result funcref))

	(memory $memory 1)
	(export "mem" (memory $memory))
	(data (i32.const 0xCAFE) "wasm.main()")

	(global $counter (mut i32) (i32.const 0))

	(func (export "main") (result)
		global.get $counter
		i32.const 123456789
		i32.add
		global.set $counter
		global.get $counter
		call $log
		global.get $counter
		i32.const 1000000000
		i32.lt_s
		(if
			(then
				i32.const 0xCAFE
				i32.const 11
				call $string.const
				call $eval_js
			)
		)
	)
)
