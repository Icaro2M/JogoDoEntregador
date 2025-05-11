extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
			
