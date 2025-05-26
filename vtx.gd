extends Node3D

signal player_entered_collision(direcao: String, objeto: Node)

func _ready():
	
	$areaNorth.connect("body_entered", _on_colisao_entered.bind(0))
	$areaSouth.connect("body_entered", _on_colisao_entered.bind(1))
	$areaEast.connect("body_entered", _on_colisao_entered.bind(2))
	$areaWest.connect("body_entered", _on_colisao_entered.bind(3))
	
func _on_colisao_entered(body: Node, direcao: int) -> void:
	if body.name == "carro":
		
		emit_signal("player_entered_collision", direcao,self)
	
