extends Node3D

@onready var minimap = $CanvasLayer/Minimap
@onready var randomVtx = null

var distance = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position()
	
func start_position():
	var vtx = get_random()
	
	minimap.destinoAtual[0] = vtx
	minimap.montar_caminho(minimap.nodeAtual,minimap.destinoAtual)
	minimap.change_destiny_position()
	$CanvasLayer2/mapagps.change_destiny_position()
	$Ponto.position = vtx.global_transform.origin
	
	placeNpc(vtx.npcStart)
	var direction = (vtx.global_transform.origin - $NPC.global_transform.origin).normalized()	
	var look_target = $NPC.global_transform.origin - direction
	$NPC.look_at(look_target, Vector3.UP)

func finish_position():
	var vtx = get_random()
	
	minimap.destinoAtual[0] = vtx
	minimap.montar_caminho(minimap.nodeAtual,minimap.destinoAtual)
	minimap.change_destiny_position()
	$CanvasLayer2/mapagps.change_destiny_position()
	$NPC.walk_away_position = vtx.npcDest.global_transform.origin
	$destino.position = vtx.global_transform.origin
	distance = minimap.distancia_total + minimap.player.global_position.distance_to(minimap.caminho_atual[0][0].global_position)
	
	

func get_random():
	var nodes = $Vtxs.get_children()
	if nodes.size() == 0:
		return null
	return nodes[randi()%nodes.size()]

func placeNpc(vtx):
	$NPC.update_npc()
	$NPC.current_state = $NPC.State.IDLE
	$NPC.position = vtx.global_transform.origin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var mapa = $CanvasLayer2
@onready var gps = $CanvasLayer

@onready var active = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("map"):
		if active:
			mapa.visible = false
			gps.visible = true
			active = false
		else:
			mapa.visible = true
			gps.visible = false
			active = true
			
