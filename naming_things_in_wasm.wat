(module
	(func $aBob:.bu$ae (export "$ehабоба:. |&=&={}") (param $x i64) (result i32)
		local.get $x
		i32.wrap_i64
	)
	(func (export "main") (result i32)
		i64.const 123
		call $aBob:.bu$ae
	)
)
