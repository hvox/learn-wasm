(module
	(func $print_i32 (import "console" "log") (param i32))
	(func $print_ref (import "console" "log") (param externref))
	(func $string.from_code_point (import "String" "fromCodePoint") (param i32) (result externref))
	(func $string.from_code_points (import "String" "fromCodePoint") (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result externref))
	(func $js.eval (import "window" "eval") (param externref) (result externref))
	(func $js.apply (import "Reflect" "apply") (param externref externref externref) (result externref))
	(func $js.array:1 (import "Array" "of") (param externref) (result externref))
	(func $js.array:2 (import "Array" "of") (param externref externref) (result externref))
	(func $js.array:2i32 (import "Array" "of") (param i32 i32) (result externref))

	(global $js.add (mut externref) (ref.null extern))
	(global $js.str (mut externref) (ref.null extern))

	(memory $memory 1)
	(export "mem" (memory $memory))
	(data (i32.const 0xABBA) "b => (i, j) => new TextDecoder().decode(b.slice(i, i + j)) ")
	(data (i32.const 0xCAFE) "Hello, world!")

	(func (export "main") (param $mem externref) (result)
		(local $i i32)
		(local $s externref)

		(; Create addition to use it later as concatenation ;)
		i32.const 0x28 i32.const 0x78 i32.const 0x2c i32.const 0x79 i32.const 0x29
		i32.const 0x3d i32.const 0x3e i32.const 0x78 i32.const 0x2b i32.const 0x79
		call $string.from_code_points
		call $js.eval
		global.set $js.add

		(; Assemble function to decode utf-8 string from wasm memory ;)
		i32.const 32
		call $string.from_code_point
		local.set $s
		(loop $decoder-code-assembling
			local.get $s
			i32.const 0xABBA
			local.get $i
			i32.add
			i32.load8_u
			call $string.from_code_point
			call $add
			local.set $s

			local.get $i
			i32.const 1
			i32.add
			local.tee $i
			i32.const 58
			i32.lt_u
			br_if $decoder-code-assembling
		)
		local.get $s
		call $js.eval
		ref.null extern
		local.get $mem
		call $js.array:1
		call $js.apply
		global.set $js.str

		(; Use created function to print greeting ;)
		i32.const 0xCAFE
		i32.const 13
		call $string.from_utf8
		call $print_ref
	)

	(func $add (param externref externref) (result externref)
		global.get $js.add
		ref.null extern
		local.get 0
		local.get 1
		call $js.array:2
		call $js.apply
	)

	(func $string.from_utf8 (param i32 i32) (result externref)
		global.get $js.str
		ref.null extern
		local.get 0
		local.get 1
		call $js.array:2i32
		call $js.apply
	)
)
