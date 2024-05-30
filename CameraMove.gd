extends Camera2D

var speed : float = GameSettings.camera_speed


func _physics_process(delta):
	var dir : Vector2 = Vector2(0,0)
	if Input.is_action_pressed("move_right"):
		dir.x = 1
	elif Input.is_action_pressed("move_left"):
		dir.x = -1
	if Input.is_action_pressed("move_up"):
		dir.y = -1
	elif Input.is_action_pressed("move_down"):
		dir.y = 1
	dir = dir.normalized()
	position += dir * speed * delta
	
	if Input.is_action_just_released("mouse_scroll_up"):
		zoom.x *= 0.9
		zoom.y *= 0.9
	elif Input.is_action_just_released("mouse_scroll_down"):
		zoom.x *= 1.1
		zoom.y *= 1.1
