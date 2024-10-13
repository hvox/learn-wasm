(module
	(func $log (import "console" "log") (param i32))
	(func $request_animation_frame (import "window" "requestAnimationFrame") (param funcref))
	(table 1 funcref)
	(elem (i32.const 0) $update)

	(global $frame (mut i32) (i32.const 0))

	(func (export "main") (result)
		ref.func $update
		call $request_animation_frame
	)

	(func $update (result)
		global.get $frame
		i32.const 1
		i32.add
		global.set $frame
		global.get $frame
		(; i32.const 0x7fffffff ;)
		i32.const 240
		i32.lt_s
		(if
			(then
				ref.func $update
				call $request_animation_frame
			)
		)
		global.get $frame
		call $log
	)
)
