window.onload = (_) => {
	const wasmImports = {
		imports: {
			log: (arg) => console.log(arg),
			logBinary: (arg) => console.log(arg),
		},
	};
	WebAssembly.instantiateStreaming(
		fetch("wasm.wasm"),
		wasmImports,
	).then(
		(obj) => {
			let code = obj.instance.exports.main();
			console.log("Code: ", code);
		},
	);
};
