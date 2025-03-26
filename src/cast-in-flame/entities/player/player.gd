class_name Player
extends CharacterBody2D

@export var base_max_speed: float = 1000
@export var base_acceleration: float = 100
@export var base_drag: float = 0.9

var can_move: bool = true

func _physics_process(delta: float) -> void:
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
