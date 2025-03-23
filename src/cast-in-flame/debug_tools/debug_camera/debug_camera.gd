extends Camera2D


var cam_speed = 200
var zoom_factor = 1.2

func _process(delta):
	var move_vector = Vector2()
	if Input.is_action_pressed("debug_camera_down"):
		move_vector += Vector2.DOWN
	if Input.is_action_pressed("debug_camera_up"):
		move_vector += Vector2.UP
	if Input.is_action_pressed("debug_camera_left"):
		move_vector += Vector2.LEFT
	if Input.is_action_pressed("debug_camera_right"):
		move_vector += Vector2.RIGHT
	position += (cam_speed / zoom.x) * move_vector.normalized() * delta
	
	
	if Input.is_action_pressed("debug_camera_zoom_in"):
		zoom *= zoom_factor
	if Input.is_action_pressed("debug_camera_zoom_out"):
		zoom /= zoom_factor
