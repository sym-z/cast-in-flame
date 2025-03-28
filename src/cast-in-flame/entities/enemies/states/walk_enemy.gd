extends State

@onready var player: Player = get_parent().character

var is_active: bool = false
var lock_direction: bool = false
var animation_name: String = "walk"

func enter():
	player.can_move = true
	
func exit():
	player.velocity = Vector2i(0,0)
	
func update(_delta: float):
	if player.velocity.length() <= 5:
		player.state_machine.change_state("Idle Player")
		return
	elif Input.is_action_just_pressed("attack"):
		player.state_machine.change_state("Attack Player")
