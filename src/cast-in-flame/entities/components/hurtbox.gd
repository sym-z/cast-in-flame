class_name HurtBox
extends Area2D

signal received_damage(damage: int)

@onready var character: CharacterBody2D = get_parent()
var timer: Timer
@export var invincibility_time: float = .5
@export var detectable: bool = true

@export var collision_shape: CollisionShape2D

var overlapping_hitboxes = []
var latest_hit_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.wait_time = invincibility_time
	timer.timeout.connect(func(): detectable = true)
	add_child(timer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hit_by(attacker: HitBox):
	if detectable:
		detectable = false
		timer.start()
		print("OUCH, ", attacker.get_parent(), " HURT ", self.get_parent())
	
	pass
