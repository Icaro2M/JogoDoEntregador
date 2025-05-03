extends Node2D


var origem_2d = Vector2()
var destino_2d = Vector2()

func _draw():
	draw_line(origem_2d, destino_2d, Color.YELLOW, 2.0)

func update_rota(origem: Vector2, destino: Vector2):
	origem_2d = origem
	destino_2d = destino
	#date()  # força redesenhar
