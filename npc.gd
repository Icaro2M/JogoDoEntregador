extends CharacterBody3D

@onready var passageiro = false

enum State { IDLE, APPROACH_PLAYER, DISAPPEAR, REAPPEAR, WALK_AWAY }

var current_state = State.IDLE
var speed = 2.0
@export var playerP: NodePath
var target_position = Vector3.ZERO
var walk_away_position = Vector3(1000, 0, 10) 
var player = null
@onready var animation = $AnimationPlayer

@onready var som_entrou = $Ponto       # Nome corrigido
@onready var som_dinheiro = $Dinheiro  # Nome corrigido

func _ready():
	player = get_node(playerP) 
	animation.play("idleN")

func _physics_process(delta):
	match current_state:
		State.IDLE:
			animation.play("idleN")
		State.APPROACH_PLAYER:
			move_towards(player.global_transform.origin, delta)
			animation.play("walkN")
			if is_close_to(player.global_transform.origin):
				$"..".finish_position()
				player.set_frozen(false)
				current_state = State.DISAPPEAR
		State.DISAPPEAR:
			visible = false
			velocity = Vector3.ZERO
		State.REAPPEAR:
			spawn_towards_target(player, walk_away_position)
			visible = true
			current_state = State.WALK_AWAY
		State.WALK_AWAY:
			move_towards(walk_away_position, delta)
			animation.play("walkN")
			if self.position.distance_to(walk_away_position) < 1.0:
				$"..".start_position()

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
			$"../CanvasLayer/Minimap".clear_routes()
			player.set_frozen(true)

			som_entrou.play()  # 🔊 Toca som ao entrar

			await get_tree().create_timer(1.0).timeout
			current_state = State.APPROACH_PLAYER
			passageiro = true

func _on_destino_body_entered(body: Node3D) -> void:
	if body.name == "carro":
		if passageiro:
			$"../CanvasLayer/Minimap".clear_routes()
			player.set_frozen(true)

			som_dinheiro.play()  # 💰 Toca som ao chegar

			await get_tree().create_timer(1.0).timeout
			current_state = State.REAPPEAR
			passageiro = false
			await get_tree().create_timer(1.0).timeout
			player.set_frozen(false)

func spawn_towards_target(player, target):
	var spawn_distance = 3.0
	var direction_to_target = (target - player.global_transform.origin).normalized()
	var spawn_position = player.global_transform.origin + direction_to_target * spawn_distance
	global_transform.origin = spawn_position
	look_at(target, Vector3.UP)

@export var textures: Array[Texture2D]

func update_npc():
	$"normal-man-a/Skeleton3D/Mesh".get_surface_override_material(0).albedo_texture = textures.pick_random()
