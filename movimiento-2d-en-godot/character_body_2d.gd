extends CharacterBody2D

@export_group("Movimiento")
@export var SPEED = 260.0

@export_group("Salto")
@export var JUMP_VELOCITY = -850.0
@export var MAX_JUMPS = 2

@export_group("Gravedad")
@export var GRAVITY = 2000.0
@export var MULTIPL_CAIDA = 2.0

@export_group("Vuelo")
@export var MAX_TIEMPO_VUELO = 1.2

var volando = false
var jump_count = 0
var tiempo_vuelo = 0

func _physics_process(delta: float) -> void:
	
	#Se genera un acumulador de saltos y se limita la cantidad de saltos en el if
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		jump_count += 1
		velocity.y = JUMP_VELOCITY
	#Se genera el estado de "volando" y se limita la velocidad en y
	if jump_count == MAX_JUMPS :
		volando = true
	
	#Es lo que sucede una vez esta en el aire . Si el estado "volando" esta activo , entonces empieza a contar "tiempo_vuelo"
	if not is_on_floor():
		if volando and tiempo_vuelo<MAX_TIEMPO_VUELO and Input.is_action_pressed("jump"):
			velocity.y = 0
			tiempo_vuelo +=delta
		else:
			volando=false
			if velocity.y <0:
				velocity.y += GRAVITY  * delta
			else:
				velocity.y += GRAVITY * MULTIPL_CAIDA *delta
			
	#Una vez llega al piso, se resetean valores
	if is_on_floor():
		jump_count = 0
		volando = false
		tiempo_vuelo = 0
		
	# Unicamente se cambia los nombres de las acciones
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
