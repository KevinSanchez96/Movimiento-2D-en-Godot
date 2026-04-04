extends CharacterBody2D

const SPEED = 260.0
const JUMP_VELOCITY = -450.0
const GRAVITY = 900.0

const MAX_JUMPS = 2
const MAX_TIEMPO_VUELO = 1.2

var volando = false
var jump_count = 0
var tiempo_vuelo = 0

func _physics_process(delta: float) -> void:
	
	#Se genera el estado de "volando" y se limita la velocidad en y
	if Input.is_action_just_pressed("jump") and jump_count == 2 and not volando:
		volando = true
		velocity.y = 0
	
	#Es lo que sucede una vez esta en el aire . Si el estado "volando" esta activo , entonces empieza a contar "tiempo_vuelo"
	if not is_on_floor():
		if volando and tiempo_vuelo<MAX_TIEMPO_VUELO:
			velocity.y = 0
			tiempo_vuelo +=delta
		else:
			velocity.y += GRAVITY * delta
	#Una vez llega al piso, se resetean valores
	if is_on_floor():
		jump_count = 0
		volando = false
		tiempo_vuelo = 0
	#Se genera un acumulador de saltos y se limita la cantidad de saltos en el if
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		jump_count += 1
		velocity.y = JUMP_VELOCITY
		
	# Unicamente se cambia los nombres de las acciones
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
