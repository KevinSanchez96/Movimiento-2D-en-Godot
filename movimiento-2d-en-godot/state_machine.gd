extends Node

var current_state : State
var state : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			state[child.name] = child
	
func change_state(new_state: String):
	if not state.has(new_state):
		push_error("No se encuentra el estado :"+new_state)
		return
		
	if current_state:
		current_state.exit()
		
	current_state = state[new_state]
	current_state.enter()
	
func _physics_process(delta):
	if current_state:
		current_state.update(delta)

	
	
	
