extends State

var is_active = false
var lock_direction = false
var animation_name = "idle"

@onready var player: Player = get_parent().character

func enter():
	pass
	
func exit():
	pass
	
func update(_delta: float):
	if player.velocity.length() > 5:
		player.state_machine.change_state("Walk Player")
		return
	elif Input.is_action_just_pressed("attack"):
		player.state_machine.change_state("Attack Player")
	#elif Input.is_action_just_pressed("debug_hurt_player"):
		#player.state_machine.change_state("Hurt")
	#elif Input.is_action_just_pressed("dash"):
		#player.state_machine.change_state("Dash")
