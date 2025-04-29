extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0, 1, 0)  # Vermelho (R, G, B)
	set_surface_override_material(0, material)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
