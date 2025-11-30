class_name Player extends CharacterBody2D

#region /// State Machine Variables
var states: Array [ PlayerState ]
var current_state : PlayerState : 
	get : return states.front()
var previous_state : PlayerState :
	get : return states [ 1 ]
	
#endregion

#region /// standard variables
var direction : Vector2 = Vector2 (0, 0)
var gravity : float = 980

#endregion

func _ready() -> void:
	#Initialize the states
	initialize_states()
	pass
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	pass
func _process(_delta: float) -> void:
	update_direction()
	change_state( current_state.process(_delta))
	pass
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	velocity.y += gravity * _delta
	change_state( current_state.physics_process(_delta))
	pass

func initialize_states() -> void:
	states = []
	#gather all states
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
	# failsafe
	if states.size() == 0:
		return
	#initialize all states
	for state in states:
		state.init()
		
		change_state( current_state )
		current_state.enter() 
	#set first state
	pass
	print (states)

func change_state( new_state : PlayerState ) -> void:
	# Safety check
	if new_state == null:
		return
	elif new_state == current_state:
		return
	# Check if current state is true, then call its exit function
	if current_state:
		current_state.exit()
	# Then set the new state
	states.push_back(new_state)
	current_state.enter()
	# Cleanup - Keep only the last three actions.
	states.resize( 3 )
	pass
func update_direction() -> void:
	#var prev_direction : Vector2 = direction
	direction = Input.get_vector("left", "right", "up", "down")
	pass
	
