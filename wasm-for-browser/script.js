const CONSOLE_LOG_ORIGINAL = console.log;
const CONSOLE_ERR_ORIGINAL = console.error;
const outputElement = document.getElementById("output");
console.log = (...args) => {
	CONSOLE_LOG_ORIGINAL(...args);
	outputElement.innerText += args.join(" ") + "\n";
};
console.error = (...args) => {
	CONSOLE_ERR_ORIGINAL(...args);
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
		let label = path.substring(0, path.length - 5).replace("-", " ");
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
	WebAssembly.instantiateStreaming(fetch(url), window).then(
		(obj) => obj.instance.exports.main()
	).catch(error => console.error(error));
}
