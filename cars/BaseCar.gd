extends VehicleBody3D


@export var STEER_SPEED = 1.5
@export var STEER_LIMIT = 0.6
var steer_target = 0
@export var engine_force_value = 40
var can_move = true

@onready var agent: NavigationAgent3D = $NavigationAgent3D
@onready var navigation_map: NavigationRegion3D = $"../city/NavigationRegion3D"  # ajuste o caminho se necessário

var target_position: Vector3 = Vector3.ZERO  # posição do destino
var path: PackedVector3Array = []

func set_destination(position: Vector3):
	target_position = position
	agent.set_target_position(target_position)
	agent.set_navigation_map(navigation_map)
	await agent.path_changed
	path = agent.get_current_path()



func _physics_process(delta):
	if can_move:
		var speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
		traction(speed)
		

		var fwd_mps = transform.basis.x.x
		steer_target = Input.get_action_strength("left") - Input.get_action_strength("right")
		steer_target *= STEER_LIMIT
		if Input.is_action_pressed("down"):
		# Increase engine force at low speeds to make the initial acceleration faster.

			if speed < 20 and speed != 0:
				engine_force = clamp(engine_force_value * 3 / speed, 0, 300)
			else:
				engine_force = engine_force_value
		else:
			engine_force = 0
		if Input.is_action_pressed("up"):
			# Increase engine force at low speeds to make the initial acceleration faster.
			if fwd_mps >= -1:
				if speed < 30 and speed != 0:
					engine_force = -clamp(engine_force_value * 10 / speed, 0, 300)
				else:
					engine_force = -engine_force_value
			else:
				brake = 1
		else:
			brake = 0.0
			
		if Input.is_action_pressed("ui_select"):
			brake=3
			$wheal2.wheel_friction_slip=0.8
			$wheal3.wheel_friction_slip=0.8
		else:
			$wheal2.wheel_friction_slip=3
			$wheal3.wheel_friction_slip=3
		steering = move_toward(steering, steer_target, STEER_SPEED * delta)
	else:
		engine_force = 0
		brake = 7
		steering = 0.0
		

func set_frozen(freeze: bool):
	
	can_move = not freeze

func traction(speed):
	apply_central_force(Vector3.DOWN*speed)
