class Graph {
	head = []

	constructor() {}
}

class Node {
	dest = 0
	next = undefined

	constructor(dest = 0, next = undefined){
		this.dest = dest;
		this.next = next;
	}
}

const create_graph = function (edges) {
	const len = edges.length;

	let graph = new Graph();

	for (const edge of edges) {
		const src = edge[0]
		const dest = edge[1]

		let node = new Node(dest, graph.head[src]);
		graph.head[src] = node;

		node = new Node(src, graph.head[dest]);
		graph.head[dest] = node;
	}

	return graph;
}

const print_graph = function (graph) {
	const head = graph.head

	for (let [index, value] of head.entries()) {
		let ptr = head[index];

		while (ptr != undefined) {
			process.stdout.write(" (" + index +  " -> " + ptr.dest + ")");
			ptr = ptr.next;
		}

		process.stdout.write("\n");
	}
}

{
	const edges = [[0, 1], [1, 2], [2, 0], [2, 1], [3, 2], [4, 5], [5, 4]];
	const graph = create_graph(edges);
	print_graph(graph);
}