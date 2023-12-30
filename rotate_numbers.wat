(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func $log_i64 (import "imports" "log") (param i64))
	(func $log_f32 (import "imports" "log") (param f32))
	(func $log_f64 (import "imports" "log") (param f64))
	(func (export "main") (result f64 f64 i64)
		(local $i i32)
		i32.const 13
		local.set $i
		(loop $my_loop (result f64 f64)
			local.get $i
			i64.extend_i32_u
			call $log_i64

			local.get $i
			i32.const 1
			i32.rotl
			local.set $i

			f64.const 1
			f64.const 12345678910111213
			local.get $i
			i32.const 13
			i32.ne
			br_if $my_loop
		)
		local.get $i
		call $log_i32
		i64.const 14
	)
)
