(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func $log_i64 (import "imports" "log") (param i64))
	(func $log_f32 (import "imports" "log") (param f32))
	(func $log_f64 (import "imports" "log") (param f64))
	(func (export "main") (result i32 i32 i32)
		i32.const 1
		i32.const 2
		i32.const 3
	)
)
