extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


const MAX_JUMPS = 2
const MAX_TIEMPO_VUELO = 1.5

var volando = false
var gravedad_volando = 30
var jump_count = 0
var tiempo_vuelo = 0
var activar_vuelo = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump") and jump_count == 2 and not volando:
		volando = true
		velocity.y = 0
		
	if not is_on_floor():
		if volando and tiempo_vuelo<MAX_TIEMPO_VUELO:
			velocity.y = 0
			tiempo_vuelo +=delta
		else:
			velocity += get_gravity() * delta
		
	if is_on_floor():
		jump_count = 0
		volando = false
		tiempo_vuelo = 0
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		jump_count += 1
		velocity.y = JUMP_VELOCITY
		


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
