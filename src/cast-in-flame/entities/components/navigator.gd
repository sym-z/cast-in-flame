extends NavigationAgent2D
class_name Navigator

#
### Updates the path every x seconds
@export var calc_path_frequency: float = 1
@export var character: CharacterBody2D
#temp
@export var my_target: Node2D
var timer: Timer
var update_path_on_timer: bool = false
var prepped = false
#
func _ready():
	NavigationServer2D.map_changed.connect(connected_to_map)
	make_timer()

func connected_to_map(_unused):
	prepped = true

func get_next_step():
	if !prepped:
		print("not prepped!")
		return character.position
	return get_next_path_position()

func timer_done():
	if update_path_on_timer:
		update_target_pos()

func turn_on():
	update_path_on_timer = true
	update_target_pos()
func turn_off():
	update_path_on_timer = false

func update_target_pos(new_pos = null):
	if new_pos:
		target_position = new_pos
		return
	var temp = my_target.position
	if temp != null:
		target_position = temp
	else:
		target_position = Vector2.ZERO

func make_timer():
	timer = Timer.new()
	timer.wait_time = calc_path_frequency
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(timer_done)
	add_child(timer)
	timer.start()
