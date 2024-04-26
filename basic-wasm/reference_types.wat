(module
	(func $i64_to_int (import "imports" "NumberToBigInt") (param $aoea i64) (result externref))
	(func $ref_add (import "imports" "add") (param externref externref) (result externref))
	(func (export "main") (result externref)
		ref.null extern
		ref.null extern
		i32.const 5
		select (result externref)
		drop

		i64.const 123
		call $i64_to_int

		i64.const 321
		call $i64_to_int
		call $ref_add
	)
)
