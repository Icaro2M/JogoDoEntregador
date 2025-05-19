extends ColorRect

@export var target : NodePath
@export var zoom_factor : float = 1
@onready var player := get_node(target)

@onready var mapa = $"../../CanvasLayer2/mapagps"
@onready var img := $SubViewportContainer/SubViewport/Rotas/Sprite2D
@onready var line := $SubViewportContainer/SubViewport/Rotas/Sprite2D/Line2D
@onready var arrow := $SubViewportContainer/SubViewport/Sprite2D2
@onready var parent := $"../../vertices"

# Lista limitada, mas com vértices conectados via neighbors corretamente
@onready var listaCaminho := [
	$"../../vertices/Inter/Vertice14",
	$"../../vertices/Inter/Vertice2",
	$"../../vertices/Inter/Vertice",
	$"../../vertices/Inter/Vertice3",
	$"../../vertices/Inter/Vertice4",
	$"../../vertices/Inter/Vertice5",
	$"../../vertices/Inter/Vertice7",
	$"../../vertices/Inter/Vertice8",
	$"../../vertices/Inter/Vertice9",
	$"../../vertices/Inter/Vertice10",
	$"../../vertices/Inter/Vertice11",
	$"../../vertices/Inter/Vertice12",
	$"../../vertices/Inter/Vertice13",
	$"../../vertices/Inter/Vertice18",
	$"../../vertices/Inter/Vertice13",
	$"../../vertices/Inter/Vertice18",
	$"../../vertices/Inter/Vertice15",
	$"../../vertices/Inter/Vertice17",
	$"../../vertices/Inter/Vertice18",
	$"../../vertices/Inter/Vertice19",
	$"../../vertices/Inter/Vertice20",
	$"../../vertices/Inter/Vertice21",
	$"../../vertices/Inter/Vertice22",
	$"../../vertices/Inter/Vertice23",
	$"../../vertices/Inter/Vertice6"
]

@onready var nodeAtual = null
@onready var camera := $SubViewportContainer/SubViewport/Camera3D

# Caminho real calculado
var caminho_atual: Array = []


func _ready():
	camera.position = Vector3(0, 1, 0)
	camera.fov = 90

	# Pega início e destino
	var start = listaCaminho[0]
	var goal = listaCaminho[-1]

	# Calcula o melhor caminho dentro dos vértices conectados
	caminho_atual = dijkstra_basico(listaCaminho, start, goal)
	montar_caminho(caminho_atual, start)


func dijkstra_basico(vertices: Array, start: Node3D, goal: Node3D) -> Array:
	var dist = {}
	var prev = {}
	var nao_visitados = []

	for v in vertices:
		dist[v] = INF
		prev[v] = null
		nao_visitados.append(v)

	dist[start] = 0

	while nao_visitados.size() > 0:
		nao_visitados.sort_custom(func(a, b): return dist[a] < dist[b])
		var atual = nao_visitados.pop_front()

		if atual == goal:
			break

		for vizinho in atual.neighbors:
			if vizinho == null or not dist.has(vizinho):
				continue
			var alt = dist[atual] + atual.global_position.distance_to(vizinho.global_position)
			if alt < dist[vizinho]:
				dist[vizinho] = alt
				prev[vizinho] = atual

	var caminho = []
	var u = goal
	while u != null:
		caminho.insert(0, u)
		u = prev[u]

	return caminho


func montar_caminho(lista: Array, node):
	line.clear_points()
	mapa.line_clear()
	var idx = lista.find(node)
	if idx == -1:
		idx = 0

	var listaC = lista.slice(idx, lista.size())

	var first = true
	for vertice in listaC:
		var point = Vector2(vertice.position.z * 3 + 60, -vertice.position.x * 3 + 70)
		line.add_point(point)
		mapa.create_line_point(vertice.position.z, vertice.position.x)
		if first:
			first = false


func _process(delta: float) -> void:
	if target:
		img.position = Vector2((-3 * player.position.z + 40) * zoom_factor, (3 * player.position.x + 30) * zoom_factor)
		arrow.rotation = -player.global_rotation.y + 80.1

		if caminho_atual.size() > 0:
			line.set_point_position(0, Vector2((player.position.z * 3 + 60) * zoom_factor, (-player.position.x * 3 + 70) * zoom_factor))
			mapa.line_follow(player.position.z, player.position.x)

			var prox = get_mais_proximo()
			if prox != nodeAtual:
				nodeAtual = prox
				montar_caminho(caminho_atual, prox)


func get_mais_proximo():
	var menor_dist = INF
	var prox: Node3D = null
	for ponto in caminho_atual:
		var distancia = player.global_position.distance_to(ponto.global_position)
		if distancia < menor_dist:
			menor_dist = distancia
			prox = ponto
	return prox
