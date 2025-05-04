extends ColorRect


@export var target : NodePath


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

func _ready() -> void:
	montar_caminho(listaCaminho,listaCaminho[0])
		

func montar_caminho(lista,node):
	line.clear_points()
	var idx = 0
	if node in lista:
		
		for i in lista.size():
			if lista[i]!=node:
				idx+=1
			else:
				break
	if idx==lista.size():
		idx-=1

	var listaC = lista.slice(idx,lista.size())
	
	
	
	var first = true
	for vertice in listaC:
		if first:
			line.add_point(Vector2(vertice.position.z*3+60,-vertice.position.x*3+70))
			first = false
		line.add_point(Vector2(vertice.position.z*3+60,-vertice.position.x*3+70))


var destino = Vector3(10, 0, 15)

func _process(delta: float) -> void:
	if target:
		
		img.position = Vector2(-3*player.position.z + 40,3*player.position.x+30)
		arrow.rotation = -player.global_rotation.y + 80.1
		
		
			
		
		line.set_point_position(0,Vector2(player.position.z*3+60,-player.position.x*3+70))
		
		var prox = get_mais_proximo()
		if prox!=nodeAtual:
			nodeAtual = prox
			montar_caminho(listaCaminho,prox)


func get_mais_proximo():
	var menor_dist = INF
	var prox: Node3D = null
	for ponto in listaCaminho:
		var distancia = player.global_position.distance_to(ponto.global_position)
		if distancia < menor_dist:
			menor_dist = distancia
			prox = ponto
	
	
	return prox


	
	
