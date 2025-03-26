class_name DirectionManager
extends Node

@onready var character: CharacterBody2D = get_parent()
@onready var sm = character.state_machine

var look_vector: Vector2

signal direction_changed(look_vector: Vector2)

func _physics_process(_delta: float) -> void:
	if sm != null && !sm.get_current_state_node().lock_direction:
		get_look_vector()
		
#func on_state_machine_changed()

func get_look_vector():
	#TODO, implement get_direction in enemies
	var new_look_vector = character.get_direction()
	
	if abs(new_look_vector.x) > abs(new_look_vector.y):
		new_look_vector = Vector2(new_look_vector.x, 0).normalized()
	elif abs(new_look_vector.x) < abs(new_look_vector.y):
		new_look_vector = Vector2(0, new_look_vector.y).normalized()
	
	if look_vector != new_look_vector:
		look_vector = new_look_vector
		direction_changed.emit(look_vector)
