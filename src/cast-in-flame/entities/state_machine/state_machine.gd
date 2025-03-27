class_name StateMachine
extends Node

#change to be a state node
@export var default_state: String = "Nil"
@export var character: CharacterBody2D

var state_names: Array[String] = []
var state_nodes = {}
var current_state: String

signal state_changed(new_state_node: State)

func _ready() -> void:
	for state in get_children():
		state_names.append(state.name)
		state_nodes[state.name] = state
	change_state(default_state)
	
func _physics_process(delta: float) -> void:
	update_state(delta)
	
func change_state(new_state: String):
	if new_state != current_state && new_state in state_names:
		if current_state in state_names:
			exit_state(current_state)
		state_changed.emit(state_nodes[new_state])
		current_state = new_state
		enter_state(new_state)
		
func enter_state(state: String):
	state_nodes[state].enter()
	state_nodes[state].is_active = true
	
func exit_state(state: String):
	state_nodes[state].exit()
	state_nodes[state].is_active = false
	
func get_current_state_node() -> State:
	return state_nodes[current_state]
	
func update_state(delta: float):
	state_nodes[current_state].update(delta)
