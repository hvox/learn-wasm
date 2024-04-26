(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func $log_i64 (import "imports" "log") (param i64))
	(func $log_f32 (import "imports" "log") (param f32))
	(func $log_f64 (import "imports" "log") (param f64))
	(func (export "main") (result f64 f64 i64)
		(local $i i32)
		(loop $my_loop (result f64 f64)
			local.get $i
			i32.const 1
			i32.add
			local.set $i

			local.get $i
			call $log_i32

			f64.const 1
			f64.const 2345678910111213
			local.get $i
			i32.const 10
			i32.lt_s
			br_if $my_loop
		)
		i64.const 14
	)
)
