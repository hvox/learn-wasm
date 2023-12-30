#!/usr/bin/env -S deno run -A

const wasmSignature = new Uint8Array([0, 97, 115, 109]);
let wasmCode = await Deno.readFile(Deno.args[0]);
if (!arraysAreEqual(wasmCode.slice(0, 4), wasmSignature)) {
	const wasmPath = await Deno.makeTempFile();
	const cmp = ["wat2wasm", Deno.args[0], "-o", wasmPath];
	await Deno.run({ cmd: cmp }).status();
	wasmCode = await Deno.readFile(wasmPath);
}
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

function arraysAreEqual(arr1: Uint8Array, arr2: Uint8Array): boolean {
	if (arr1.length != arr2.length) return false;
	return arr1.every((value, index) => value === arr2[index]);
}
