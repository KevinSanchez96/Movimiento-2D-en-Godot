extends State

func enter():
	player.tiempo_vuelo = 0.0
	
func update(delta):
	var direction = Input.get_axis("move_left","move_right")
	player.velocity.x = direction * player.speed
	
	if Input.is_action_pressed("jump") and player.tiempo_vuelo < player.max_tiempo_vuelo:
		player.velocity.y = 0
		player.tiempo_vuelo += delta
	else:
		state_machine.change_state("Fall")
	
	
