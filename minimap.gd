extends ColorRect

@export var target : NodePath
@export var zoom_factor : float = 1  # Fator de zoom positivo para reduzir o zoom, onde 1 é o padrão
@onready var player := get_node(target)

@onready var img := $SubViewportContainer/SubViewport/Rotas/Sprite2D
@onready var line := $SubViewportContainer/SubViewport/Rotas/Sprite2D/Line2D
@onready var arrow := $SubViewportContainer/SubViewport/Sprite2D2
@onready var parent := $"../../vertices"

@onready var listaCaminho := [$"../../vertices/Inter/Vertice14",
							$"../../vertices/Inter/Vertice10",
							$"../../vertices/Inter/Vertice9",			
							$"../../vertices/Inter/Vertice6"]

@onready var nodeAtual = null
@onready var camera := $SubViewportContainer/SubViewport/Camera3D

func _ready() -> void:
	camera.position = Vector3(0, 1, 0)
	camera.fov = 90

	montar_caminho(listaCaminho, listaCaminho[0])

func montar_caminho(lista, node):
	line.clear_points()
	var idx = 0
	if node in lista:
		for i in lista.size():
			if lista[i] != node:
				idx += 1
			else:
				break
	if idx == lista.size():
		idx -= 1

	var listaC = lista.slice(idx, lista.size())

	var first = true
	for vertice in listaC:
		if first:
			line.add_point(Vector2(vertice.position.z * 3 + 60, -vertice.position.x * 3 + 70))
			first = false
		line.add_point(Vector2(vertice.position.z * 3 + 60, -vertice.position.x * 3 + 70))

func _process(delta: float) -> void:
	if target:
		img.position = Vector2((-3 * player.position.z + 40) * zoom_factor, (3 * player.position.x + 30) * zoom_factor)
		arrow.rotation = -player.global_rotation.y + 80.1

		line.set_point_position(0, Vector2((player.position.z * 3 + 60) * zoom_factor, (-player.position.x * 3 + 70) * zoom_factor))

		var prox = get_mais_proximo()
		if prox != nodeAtual:
			nodeAtual = prox
			montar_caminho(listaCaminho, prox)

func get_mais_proximo():
	var menor_dist = INF
	var prox: Node3D = null
	for ponto in listaCaminho:
		var distancia = player.global_position.distance_to(ponto.global_position)
		if distancia < menor_dist:
			menor_dist = distancia
			prox = ponto
	return prox
