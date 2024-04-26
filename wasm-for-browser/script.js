window.ORIGINAL_CONSOLE_LOG = console.log;
window.ORIGINAL_CONSOLE_ERROR = console.error;
const outputElement = document.getElementById("output");
console.log = (...args) => {
	ORIGINAL_CONSOLE_LOG(...args);
	outputElement.innerText += args.join(" ") + "\n";
};
console.error = (...args) => {
	ORIGINAL_CONSOLE_ERROR(...args);
	outputElement.innerText += args.join(" ") + "\n";
}

window.onload = () => {
	let path = new URLSearchParams(window.location.search).get("t");
	if (path != null) {
		document.getElementById("wasm-module-list").style = "display:none";
		executeWasm(path);
		return;
	}

	[...document.getElementsByTagName("a")].forEach((link) => {
		let path = link.pathname.substring(link.pathname.lastIndexOf("/") + 1);
		let label = path.substring(0, path.length - 5).replace(/-/g, " ");
		label = label[0].toUpperCase() + label.substring(1);
		link.innerText = label;
		link.onclick = (e) => {
			e.preventDefault();
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set("t", path);
			window.location.search = urlParams;
		};
	});
}

function executeWasm(url) {
	document.getElementById("output").innerText = "";
	console.log("> Executing", url);

	WebAssembly.instantiateStreaming(fetch(url, { cache: "no-store" }), window).then(
		(obj) => (window.wasm = obj.instance.exports).main()
	).catch(error => console.error(error));
}

window.s = (ptr, length) => {
	let string = new TextDecoder().decode(wasm.mem.buffer.slice(ptr, ptr + length));
	// console.log(string);
	return string;
}
