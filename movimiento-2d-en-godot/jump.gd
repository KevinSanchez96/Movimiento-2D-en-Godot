extends State

func enter():
	player.velocity.y = player.jump_velocity
	player.jump_count = 1

func update(delta):
	apply_gravity(delta)
	
	var direction = Input.get_axis("move_left","move_right")
	player.velocity.x = direction * player.speed
	
	if Input.is_action_just_pressed("jump") and player.jump_count < player.max_jumps:
		player.jump_count += 1
		
		if player.jump_count == 2:
			player.velocity.y = player.jump_velocity * 1.15
		else:
			player.velocity.y = player.jump_velocity
	
	if player.jump_count == player.max_jumps and Input.is_action_pressed("jump") and player.velocity.y > 0:
		state_machine.change_state("Fly")
		return
	
	if player.velocity.y > 0:
		state_machine.change_state("Fall")
		return

func apply_gravity(delta):
	if player.velocity.y < 0:
		player.velocity.y += player.gravity * delta
	else:
		player.velocity.y += player.gravity * player.multipl_caida * delta
