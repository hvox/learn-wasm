(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func $log_i64 (import "imports" "log") (param i64))
	(func $log_f32 (import "imports" "log") (param f32))
	(func $log_f64 (import "imports" "log") (param f64))
	(func (export "main") (result i32)
		(block $aboba
			(block $buba
				i32.const 1
				br_table $aboba $buba
			)
			f64.const 111
			call $log_f64
			i32.const 111
			return
		)
		f64.const 222
		call $log_f64
		i32.const 222
	)
)
