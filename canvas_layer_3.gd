extends CanvasLayer

@onready var label = $PontuacaoLabel
var dist: int = 0

func atualizar_distancia(valor: int):
	dist = valor
	label.text = "Distância percorrida: %.2f m" % dist
