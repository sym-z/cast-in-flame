extends State
var is_active = false
var lock_direction = true
var animation_name = "attack"

@onready var character: CharacterBody2D = get_parent().character

func enter():
	character.hitbox.turn_on()
	
func exit():
	character.hitbox.turn_off()
	
func update(_delta: float):
	pass

func animation_end():
	character.state_machine.change_state("Idle Player")
