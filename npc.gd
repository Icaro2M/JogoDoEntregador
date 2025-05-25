extends CharacterBody3D

@onready var passageiro = false

enum State { IDLE, APPROACH_PLAYER, DISAPPEAR, REAPPEAR, WALK_AWAY }

var current_state = State.IDLE
var speed = 2.0
@export var playerP: NodePath
var target_position = Vector3.ZERO
var walk_away_position = Vector3(1000, 0, 10) # lugar onde ele vai depois de reaparecer
var player = null
@onready var animation = $AnimationPlayer

func _ready():
	player = get_node(playerP) # ajuste o caminho até o Player
	animation.play("idleN")

func _physics_process(delta):
	
	match current_state:
		State.IDLE:
			animation.play("idleN")
			# espera alguma condição externa
		State.APPROACH_PLAYER:
			move_towards(player.global_transform.origin, delta)
			animation.play("walkN")
			if is_close_to(player.global_transform.origin):
				
				player.set_frozen(false)
				current_state = State.DISAPPEAR
		State.DISAPPEAR:
			visible = false
			velocity = Vector3.ZERO  # Garantir que o NPC pare de se mover
			
			
		State.REAPPEAR:
			global_transform.origin = player.global_transform.origin + Vector3(3, 0, 0)
			visible = true
			current_state = State.WALK_AWAY
		State.WALK_AWAY:
			move_towards(walk_away_position, delta)
			animation.play("walkN")
			if is_close_to(walk_away_position):
				
				visible = false
				current_state = State.IDLE

func move_towards(target: Vector3, delta: float):
	var direction = (target - global_transform.origin).normalized()
	velocity = direction * speed
	
	var look_target = global_transform.origin - direction
	look_at(look_target, Vector3.UP)
	move_and_slide()

func is_close_to(target: Vector3) -> bool:
	return global_transform.origin.distance_to(target) < 3.0
	


func _on_ponto_body_entered(body: Node3D) -> void:
	if body.name == "carro":
		
		if not passageiro:
			player.set_frozen(true)
			await get_tree().create_timer(1.0).timeout
			current_state = State.APPROACH_PLAYER
			passageiro = true


func _on_destino_body_entered(body: Node3D) -> void:
	if body.name == "carro":
		if passageiro:
			player.set_frozen(true)
			await get_tree().create_timer(1.0).timeout
			current_state = State.REAPPEAR
			passageiro = false
			await get_tree().create_timer(1.0).timeout
			player.set_frozen(false)
