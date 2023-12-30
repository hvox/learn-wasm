#!/usr/bin/env -S deno run -A

const wasmCode = await Deno.readFile(Deno.args[0]);
const wasmModule = new WebAssembly.Module(wasmCode);
const imports = {
	log: (x: number) => console.log(x),
	NumberToBigInt: (x: number) => BigInt(x),
	add: (x: number, y: number) => x + y,
	logBinary: (x: number) =>
		console.log(x.toString(2).padStart(64, "-").match(/.{8}/g)?.join(" ")),
};
const wasmInstance = new WebAssembly.Instance(wasmModule, { imports });
const main = wasmInstance.exports.main as CallableFunction;
console.log("RESULT:", main());
