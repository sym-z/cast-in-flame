extends State

@onready var player: Player = get_parent().character

var is_active = false
var lock_direction = false

func enter():
	player.can_move = true
	
func exit():
	player.velocity = Vector2i(0,0)
	
func update(_delta: float):
	pass
