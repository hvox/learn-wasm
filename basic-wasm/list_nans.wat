(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func $log_i64 (import "imports" "log") (param i64))
	(func $log_f32 (import "imports" "log") (param f32))
	(func $log_f64 (import "imports" "log") (param f64))
	(func $log_binary_i64 (import "imports" "logBinary") (param i64))
	(func (export "main") (result i32)
		(local $counter i32)
		(local $i i32)
		(local $float f32)
		(loop $counting_nans_loop
			local.get $i
			f32.reinterpret_i32
			local.tee $float
			local.get $float
			f32.ne
			(if
				(then
					local.get $i
					i64.extend_i32_u
					call $log_binary_i64

					local.get $counter
					i32.const 1
					i32.add
					local.set $counter
				)
			)

			local.get $i
			i32.const 1
			i32.add
			local.tee $i
			i32.const 0
			i32.ne
			br_if $counting_nans_loop
		)
		local.get $counter
	)
)
