extends CharacterBody2D

@export_group("Movimiento")
@export var speed = 300.0

@export_group("Salto")
@export var jump_velocity = -800.0
@export var max_jumps = 2

@export_group("Gravedad")
@export var gravity = 1800.0
@export var multipl_caida = 2.2

@export_group("Vuelo")
@export var max_tiempo_vuelo = 1.2
@export var tiempo_vuelo = 0.0

var jump_count = 0
@onready var state_machine = $StateMachine

func _ready():
	for state in state_machine.get_children():
		state.player = self
		state.state_machine = state_machine
	state_machine.change_state("Idle")

func _physics_process(delta):
	move_and_slide()
	
	if is_on_floor():
		jump_count = 0
