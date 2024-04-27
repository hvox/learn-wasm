(module
	(func $print_i32 (import "console" "log") (param i32))
	(func $print_ref (import "console" "log") (param externref))
	(func $string.from_code_points (import "String" "fromCodePoint") (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result externref))
	(func $js.eval (import "window" "eval") (param externref) (result externref))
	(func $js.apply (import "Reflect" "apply") (param externref externref externref) (result externref))
	(func $js.array:1 (import "Array" "of") (param externref) (result externref))
	(func $js.array:2i32 (import "Array" "of") (param i32 i32) (result externref))

	(global $js.str (mut externref) (ref.null extern))

	(memory $memory 1)
	(export "mem" (memory $memory))
	(data (i32.const 0xCAFE) "Hello from WASM")

	(func (export "main") (param $mem externref) (result)
		(local $i i32)
		(local $s externref)

		(; b=>(x,y)=>new TextDecoder().decode(b.slice(x,x+y)) ;)
		i32.const 0x62 i32.const 0x3d i32.const 0x3e i32.const 0x28 i32.const 0x78 i32.const 0x2c i32.const 0x79
		i32.const 0x29 i32.const 0x3d i32.const 0x3e i32.const 0x6e i32.const 0x65 i32.const 0x77 i32.const 0x20
		i32.const 0x54 i32.const 0x65 i32.const 0x78 i32.const 0x74 i32.const 0x44 i32.const 0x65 i32.const 0x63
		i32.const 0x6f i32.const 0x64 i32.const 0x65 i32.const 0x72 i32.const 0x28 i32.const 0x29 i32.const 0x2e
		i32.const 0x64 i32.const 0x65 i32.const 0x63 i32.const 0x6f i32.const 0x64 i32.const 0x65 i32.const 0x28
		i32.const 0x62 i32.const 0x2e i32.const 0x73 i32.const 0x6c i32.const 0x69 i32.const 0x63 i32.const 0x65
		i32.const 0x28 i32.const 0x78 i32.const 0x2c i32.const 0x78 i32.const 0x2b i32.const 0x79 i32.const 0x29
		i32.const 0x29
		call $string.from_code_points
		call $js.eval
		ref.null extern
		local.get $mem
		call $js.array:1
		call $js.apply
		global.set $js.str

		(; Use created function to print greeting ;)
		i32.const 0xCAFE
		i32.const 15
		call $string.from_utf8
		call $print_ref
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
