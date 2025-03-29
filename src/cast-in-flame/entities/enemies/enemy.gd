extends CharacterBody2D
@export var base_max_speed: float = 1000
@export var base_acceleration: float = 100
@export var base_drag: float = 0.9
@export var state_machine: StateMachine
@export var direction_manager: DirectionManager
@export var hitbox: HitBox
@export var hurtbox: HurtBox
@export var navigator: Navigator

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_direction():
	return velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_and_slide()
	pass
