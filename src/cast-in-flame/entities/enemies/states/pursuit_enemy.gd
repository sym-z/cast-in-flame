extends State

@onready var character: CharacterBody2D = get_parent().character
@export var player: Player

var is_active: bool = false
var lock_direction: bool = false
var animation_name: String = "walk"
var speed = 10

func enter():
	
	pass

func exit():
	
	pass
	
func update(_delta: float):
	var dir_vec = player.position - character.position
	character.velocity = speed * dir_vec.normalized()
