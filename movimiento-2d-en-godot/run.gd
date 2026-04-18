extends State

func update(_delta):
	var dir = Input.get_axis("move_left","move_right")
	player.velocity.x = dir * player.speed
	
	if dir==0:
		state_machine.change_state("Idle")
		
	if Input.is_action_just_pressed("jump"):
		player.jump_count+=1
		player.velocity.y = player.jump_velocity
		state_machine.change_state("Jump")
