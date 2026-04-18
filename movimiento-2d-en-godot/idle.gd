extends State

func enter():
	player.velocity.x = 0
	
func update(_delta):
	if Input.get_axis("move_left","move_right") != 0:
		state_machine.change_state("Run")
	
	if Input.is_action_just_pressed("jump"):
		player.jump_count +=1
		player.velocity.y = player.jump_velocity
		state_machine.change_state("Jump")
