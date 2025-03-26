class_name State
extends Node

# SAMPLE STATE:
# copy and paste this code into a script on a new node as a child of this node
# name the node what you want the state to be changed

'''
#extends State

# Exports
@export var player:CharacterBody2D
@export var lock_direction = false
@export var movement_details =  {}
@export var animation_name = "idle"

# Other variables
@onready var sm = get_parent()
var callbacks = {}
var direction_dependent = true
var is_active = false

# Main Functions 
func update(delta):
	if player.velocity.length() > 5:
		sm.change_state("Walk")
		return
	elif Input.is_action_just_pressed("attack"):
		sm.change_state("Attack")
	elif Input.is_action_just_pressed("debug_hurt_player"):
		sm.change_state("Hurt")
	elif Input.is_action_just_pressed("dash"):
		sm.change_state("Dash")
	pass
func enter():
	pass
func exit():
	pass
'''
