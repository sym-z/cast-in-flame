class_name HurtBox
extends Area2D

signal received_damage(damage:int)

@onready var character: CharacterBody2D = get_parent()
@export var timer: Timer
@export var invincibility_time: float = .5
@export var detectable: bool = false

@export var collisionshape :CollisionShape2D

var overlapping_hitboxes = []
var latest_hit_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
