class_name Player
extends CharacterBody2D

@export var base_max_speed: float = 1000
@export var base_acceleration: float = 100
@export var base_drag: float = 0.9
@export var state_machine: StateMachine
@export var direction_manager: DirectionManager

var can_move: bool = true

func _physics_process(_delta: float) -> void:
	decide_direction()
	apply_state_modifiers()
	move_and_slide()

func decide_direction():
	var input_direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input_direction +=  Vector2(0,-1)
	if Input.is_action_pressed("down"):
		input_direction +=  Vector2(0,1)
	if Input.is_action_pressed("left"):
		input_direction +=  Vector2(-1,0)
	if Input.is_action_pressed("right"):
		input_direction +=  Vector2(1,0)
	
	self.velocity = input_direction.normalized() * base_acceleration

func apply_state_modifiers():
	#apply any movement modifiers from state to player
	pass

func get_direction() -> Vector2:
	#mouse input case
	if Input.get_connected_joypads().size() == 0:
		var mouse_position = get_global_mouse_position()
		return (mouse_position - self.position).normalized()
	#joypad input case
	else:
		pass
		#TODO bind the look inputs in the InputMap
		#var look_dir = Input.get_vector("look_left", "look_right", "look_up", "look_down")
		#look_dir = Vector2(Input.get_action_strength("look_right") - Input.get_action_strength("look_left"), 
		#Input.get_action_strength("look_down")-Input.get_action_strength("look_up")).limit_length(1.0)
	
	return Vector2.ZERO
