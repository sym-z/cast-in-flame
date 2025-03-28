extends State
var is_active = false
var lock_direction = true
var animation_name = "attack"

@onready var player: Player = get_parent().character

func enter():
	print("enter attack")
	player.hitbox.turn_on()
	
func exit():
	player.hitbox.turn_off()
	
func update(_delta: float):
	pass

func animation_end():
	player.state_machine.change_state("Idle Player")
