@icon ( "res://player/states/state.svg" )
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region /// state references
# Reference to all other states

#endregion
# Template for every state that a state should do.

# What happens when this state is initialized?
func init() -> void:
	#print ("init! ", name)
	pass

# What happens when we enter this state?
func enter() -> void:
	#print ("enter: ", name)
	pass

# What happens when we exit this state?
func exit() -> void:
	#print ("exit: ", name)
	pass

# What happens when an input is pressed?
func handle_input( _event : InputEvent ) -> PlayerState:
	#if _event.is_action_pressed("jump"):
		#print ("jump: ", name)
	return next_state

# What happens each process tick in this state?
func process ( _delta: float ) -> PlayerState:
	return next_state

# What happens each physics_process tick in this state?
func physics_process ( _delta: float ) -> PlayerState:
	return next_state
