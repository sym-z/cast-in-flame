extends State

@onready var character: CharacterBody2D = get_parent().character
@export var player: Player

var is_active: bool = false
var lock_direction: bool = false
var animation_name: String = "walk"
var speed = 500

func enter():
	character.navigator.turn_on()
	pass

func exit():
	character.navigator.turn_off()
	pass

# TODO Make this better
# Maybe a mobility manager
func update(_delta: float):
	var dir_vec = character.navigator.get_next_step() - character.position
	character.velocity = speed * dir_vec.normalized()
