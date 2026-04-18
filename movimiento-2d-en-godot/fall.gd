extends State

func update(delta):
	apply_gravity(delta)
	
	var direction = Input.get_axis("move_left","move_right")
	player.velocity.x = direction * player.speed
	
	if player.is_on_floor():
		state_machine.change_state("Idle")
	
	if player.jump_count == player.max_jumps and Input.is_action_just_pressed("jump") and player.tiempo_vuelo < player.max_tiempo_vuelo:
		state_machine.change_state("Fly")

func apply_gravity(delta):
	if player.velocity.y < 0:
		player.velocity.y += player.gravity * delta
	else:
		player.velocity.y += player.gravity * player.multipl_caida * delta
