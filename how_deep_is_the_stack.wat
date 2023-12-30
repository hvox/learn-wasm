(module
	(func $log_i32 (import "imports" "log") (param i32))
	(func $log_i64 (import "imports" "log") (param i64))
	(func $log_f32 (import "imports" "log") (param f32))
	(func $log_f64 (import "imports" "log") (param f64))
	(func $log_binary_i64 (import "imports" "logBinary") (param i64))
	(func $check_stack (param $depth i64) 
		(local i64)
		(local i64)
		(local i64)
		local.get $depth
		i64.const 1
		i64.add
		local.tee $depth
		call $log_i64
		local.get $depth
		call $check_stack
	)
	(func (export "main") (result)
		i64.const 0
		call $check_stack
	)
)
