extends ColorRect


@export var target : NodePath
@export var camera_distance := 20.0
@onready var player := get_node(target)
@onready var camera := $SubViewportContainer/SubViewport/Camera3D
@onready var img := $SubViewportContainer/SubViewport/Sprite2D
@onready var arrow := $SubViewportContainer/SubViewport/Sprite2D2


func _process(delta: float) -> void:
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x,camera_distance,player.position.z)
		img.position = Vector2(-3*player.position.z + 40,3*player.position.x+30)
		arrow.rotation = -player.global_rotation.y + 80.1
		
