extends ColorRect

enum sentidos{NORTH, SOUTH, EAST, WEST}


@export var target : NodePath
@onready var player := get_node(target)

@onready var mapa = $"../../CanvasLayer2/mapagps"
@onready var img := $SubViewportContainer/SubViewport/Rotas/Sprite2D
@onready var line := $SubViewportContainer/SubViewport/Rotas/Sprite2D/Line2D
@onready var arrow := $SubViewportContainer/SubViewport/Sprite2D2
@onready var parent := $"../../Vtxs"

@onready var listaCaminho:= {
	$"../../Vtxs/Vtx":{
		"N":null,
		"S":$"../../Vtxs/Vtx3",
		"E":null,
		"W":$"../../Vtxs/Vtx2"	
	},
	$"../../Vtxs/Vtx2":{
		"N":null,
		"S":$"../../Vtxs/Vtx4",
		"E":$"../../Vtxs/Vtx",
		"W":null	
	},
	$"../../Vtxs/Vtx3":{
		"N":$"../../Vtxs/Vtx",
		"S":$"../../Vtxs/Vtx6",
		"E":null,
		"W":$"../../Vtxs/Vtx4"	
	},
	$"../../Vtxs/Vtx4":{
		"N":$"../../Vtxs/Vtx2",
		"S":null,
		"E":$"../../Vtxs/Vtx3",
		"W":$"../../Vtxs/Vtx5"	
	},
	$"../../Vtxs/Vtx5":{
		"N":null,
		"S":$"../../Vtxs/Vtx8",
		"E":$"../../Vtxs/Vtx4",
		"W":null	
	},
	$"../../Vtxs/Vtx6":{
		"N":$"../../Vtxs/Vtx3",
		"S":$"../../Vtxs/Vtx9",
		"E":null,
		"W":$"../../Vtxs/Vtx7"	
	},
	$"../../Vtxs/Vtx7":{
		"N":null,
		"S":$"../../Vtxs/Vtx10",
		"E":$"../../Vtxs/Vtx6",
		"W":$"../../Vtxs/Vtx8"	
	},
	$"../../Vtxs/Vtx8":{
		"N":$"../../Vtxs/Vtx5",
		"S":$"../../Vtxs/Vtx11",
		"E":$"../../Vtxs/Vtx7",
		"W":null	
	},
	$"../../Vtxs/Vtx9":{
		"N":$"../../Vtxs/Vtx6",
		"S":$"../../Vtxs/Vtx13",
		"E":null,
		"W":$"../../Vtxs/Vtx10"	
	},
	$"../../Vtxs/Vtx10":{
		"N":$"../../Vtxs/Vtx7",
		"S":$"../../Vtxs/Vtx14",
		"E":$"../../Vtxs/Vtx9",
		"W":$"../../Vtxs/Vtx11"	
	},
	$"../../Vtxs/Vtx11":{
		"N":$"../../Vtxs/Vtx8",
		"S":$"../../Vtxs/Vtx15",
		"E":$"../../Vtxs/Vtx10",
		"W":$"../../Vtxs/Vtx12"	
	},
	$"../../Vtxs/Vtx12":{
		"N":null,
		"S":$"../../Vtxs/Vtx16",
		"E":$"../../Vtxs/Vtx11",
		"W":null	
	},
	$"../../Vtxs/Vtx13":{
		"N":$"../../Vtxs/Vtx9",
		"S":$"../../Vtxs/Vtx17",
		"E":null,
		"W":$"../../Vtxs/Vtx14"
	},
	$"../../Vtxs/Vtx14":{
		"N":$"../../Vtxs/Vtx10",
		"S":$"../../Vtxs/Vtx18",
		"E":$"../../Vtxs/Vtx13",
		"W":$"../../Vtxs/Vtx15"	
	},
	$"../../Vtxs/Vtx15":{
		"N":$"../../Vtxs/Vtx11",
		"S":$"../../Vtxs/Vtx19",
		"E":$"../../Vtxs/Vtx14",
		"W":$"../../Vtxs/Vtx24"	
	},
	$"../../Vtxs/Vtx16":{
		"N":$"../../Vtxs/Vtx12",
		"S":null,
		"E":$"../../Vtxs/Vtx24",
		"W":null	
	},
	$"../../Vtxs/Vtx17":{
		"N":$"../../Vtxs/Vtx13",
		"S":$"../../Vtxs/Vtx21",
		"E":null,
		"W":$"../../Vtxs/Vtx18"	
	},
	$"../../Vtxs/Vtx18":{
		"N":$"../../Vtxs/Vtx14",
		"S":$"../../Vtxs/Vtx22",
		"E":$"../../Vtxs/Vtx17",
		"W":$"../../Vtxs/Vtx19"	
	},
	$"../../Vtxs/Vtx19":{
		"N":$"../../Vtxs/Vtx15",
		"S":$"../../Vtxs/Vtx23",
		"E":$"../../Vtxs/Vtx18",
		"W":$"../../Vtxs/Vtx20"	
	},
	$"../../Vtxs/Vtx20":{
		"N":$"../../Vtxs/Vtx24",
		"S":null,
		"E":$"../../Vtxs/Vtx19",
		"W":null	
	},
	$"../../Vtxs/Vtx21":{
		"N":$"../../Vtxs/Vtx17",
		"S":null,
		"E":null,
		"W":$"../../Vtxs/Vtx22"	
	},
	$"../../Vtxs/Vtx22":{
		"N":$"../../Vtxs/Vtx18",
		"S":null,
		"E":$"../../Vtxs/Vtx21",
		"W":$"../../Vtxs/Vtx23"	
	},
	$"../../Vtxs/Vtx23":{
		"N":$"../../Vtxs/Vtx19",
		"S":null,
		"E":$"../../Vtxs/Vtx22",
		"W":null	
	},
	$"../../Vtxs/Vtx24":{
		"N":null,
		"S":$"../../Vtxs/Vtx20",
		"E":$"../../Vtxs/Vtx15",
		"W":$"../../Vtxs/Vtx16"	
	},
	
}






# Caminho real calculado
@onready var caminho_atual: Array = []



@onready var nodeAtual = [null,null]
@onready var destinoAtual = [null,null]
	

func _ready():
	

	
	nodeAtual[0] = $"../../Vtxs/Vtx14"
	destinoAtual[0] = $"../../Vtxs/Vtx6"
	montar_caminho(nodeAtual,destinoAtual)

	

func definir_caminho(start):
	return $"../../Vtxs/Vtx11"


func dijkstra_basico(startN: Array, goalN: Array) -> Array:
	var start = startN[0]
	var goal = goalN[0]
	
	
	
	
	var dist = {}
	var prev = {}
	var sentido = {}
	var nao_visitados = []

	for v in listaCaminho:
		dist[v] = INF
		prev[v] = null
		sentido[v] = null
		nao_visitados.append(v)

	dist[start] = 0

	while nao_visitados.size() > 0:
		nao_visitados.sort_custom(func(a, b): return dist[a] < dist[b])
		var atual = nao_visitados.pop_front()

		#if atual == goal:
		#	break
		
		var vizinhos = [listaCaminho[atual]["N"],listaCaminho[atual]["S"],listaCaminho[atual]["E"],listaCaminho[atual]["W"]]
		
		
		for vizinho in vizinhos:
			if vizinho == null or not dist.has(vizinho):
				continue
			var alt = dist[atual] + atual.global_position.distance_to(vizinho.global_position)
			if alt < dist[vizinho]:
				dist[vizinho] = alt
				prev[vizinho] = atual
				if listaCaminho[atual]["N"] == vizinho:
					sentido[vizinho] = sentidos.NORTH
				elif listaCaminho[atual]["S"] == vizinho:
					sentido[vizinho] = sentidos.SOUTH
				elif listaCaminho[atual]["E"] == vizinho:
					sentido[vizinho] = sentidos.EAST
				else:
					sentido[vizinho] = sentidos.WEST
		

	var caminho = []
	var u = goal
	while u != null:
		caminho.insert(0, [u,sentido[u]])
		u = prev[u]
		##############################
	
	return caminho
	


func montar_caminho(start,goal):
	caminho_atual = dijkstra_basico(start,goal)
	line.clear_points()
	mapa.line_clear()
	var first = true
	for i in caminho_atual:
		var vertice = i[0]
		line.add_point(Vector2(vertice.position.z * 3 + 60, -vertice.position.x * 3 + 70))
		mapa.create_line_point(vertice.position.z, vertice.position.x)
		if first:
			line.add_point(Vector2(vertice.position.z * 3 + 60, -vertice.position.x * 3 + 70))
			first = false
	


func _process(delta: float) -> void:
	if target:
		
		img.position = Vector2((-3 * player.position.z + 40) , (3 * player.position.x + 30))
		arrow.rotation = -player.global_rotation.y + 80.1
		
		if caminho_atual.size() > 0:
			if line.get_point_count() > 0:
				line.set_point_position(0, Vector2((player.position.z * 3 + 60) , (-player.position.x * 3 + 70)))
			mapa.line_follow(player.position.z, player.position.x)
			var prox = get_mais_proximo()
			
			if prox[0] != nodeAtual[0]:
				nodeAtual[0] = prox[0]
				montar_caminho(prox,destinoAtual)


func get_mais_proximo():
	
	var menor_dist = INF
	var prox: Array = [null,null]
	
	for ponto in listaCaminho:
		
		var distancia = player.global_position.distance_to(ponto.global_position)
		if distancia < menor_dist:
			menor_dist = distancia
			prox[0] = ponto
	return prox
