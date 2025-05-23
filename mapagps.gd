extends ColorRect

@onready var arrow := $Control/SubViewportContainer/SubViewport/Sprite2D2
@onready var line := $Control/SubViewportContainer/SubViewport/Rotas/Sprite2D/Line2D

@export var target : NodePath
@onready var player := get_node(target)

@onready var iniciou = false


func _process(delta: float) -> void:
	arrow.position = Vector2(4.1*player.position.z + 530,-4.1*player.position.x + 470)
	arrow.rotation = -player.global_rotation.y + 80.1
	
func _ready() -> void:
	iniciou = true

	
	

func create_line_point(pos_z,pos_x):
	if iniciou:		
		line.add_point(Vector2(2.9*pos_z + 57, 2.9*-pos_x + 60))

func line_follow(pos_z, pos_x):
	if iniciou and line.get_point_count() > 0:
		line.set_point_position(0, Vector2(2.9 * pos_z + 57, 2.9 * -pos_x + 60))

func line_clear():
	if iniciou:
		line.clear_points()
		line.add_point(Vector2.ZERO)  
