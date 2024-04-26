(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func $log_i64 (import "imports" "log") (param i64))
	(func $log_f32 (import "imports" "log") (param f32))
	(func $log_f64 (import "imports" "log") (param f64))
	(func $log_binary_i64 (import "imports" "logBinary") (param i64))
	(func (export "main") (result i64)
		i32.const 2
		i32.const -3
		i32.rem_s
		call $log_i32
		i64.const 123
		i64.const 0
		i64.div_u
	)
)
