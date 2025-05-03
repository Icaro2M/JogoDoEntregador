extends ColorRect


@export var target : NodePath
@export var camera_distance := 20.0
#@export var destino : NodePath
#@onready var ponto_destino := get_node(destino)
@onready var player := get_node(target)
@onready var camera := $SubViewportContainer/SubViewport/Camera3D
@onready var img := $SubViewportContainer/SubViewport/Rotas/Sprite2D
@onready var line := $SubViewportContainer/SubViewport/Rotas/Sprite2D/Line2D
@onready var arrow := $SubViewportContainer/SubViewport/Sprite2D2

@onready var parent := $"../../vertices"

func _ready() -> void:
	var first = true
	for child in parent.get_children():
		for vertice in child.get_children():
			if first:
				line.add_point(Vector2(vertice.position.z*3+60,-vertice.position.x*3+70))
				first = false
			line.add_point(Vector2(vertice.position.z*3+60,-vertice.position.x*3+70))
		break

var destino = Vector3(10, 0, 15)

func _process(delta: float) -> void:
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x,camera_distance,player.position.z)
		img.position = Vector2(-3*player.position.z + 40,3*player.position.x+30)
		arrow.rotation = -player.global_rotation.y + 80.1
		
		
			
		
		line.set_point_position(0,Vector2(player.position.z*3+60,-player.position.x*3+70))
		
	#var origem = player.global_transform.origin
	#var destino = ponto_destino.global_transform.origin
	
	#var origem_2d = camera.unproject_position(origem)
	#var destino_2d = camera.unproject_position(destino)


	
	
