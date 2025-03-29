extends State

var is_active = false
var lock_direction = false
var animation_name = "idle"

@onready var character: CharacterBody2D = get_parent().character

func enter():
	pass
	
func exit():
	pass
	
func update(_delta: float):
	if character.velocity.length() > 5:
		character.state_machine.change_state("Walk Player")
		return
	elif Input.is_action_just_pressed("attack"):
		character.state_machine.change_state("Attack Player")
	#elif Input.is_action_just_pressed("debug_hurt_character"):
		#character.state_machine.change_state("Hurt")
	#elif Input.is_action_just_pressed("dash"):
		#character.state_machine.change_state("Dash")
