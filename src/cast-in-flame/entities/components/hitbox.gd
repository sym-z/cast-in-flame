class_name HitBox
extends Area2D
##src: https://www.youtube.com/watch?v=rU-JfP2nOpo&ab_channel=blazeDev
@export var character: CharacterBody2D
@export var damage: int = 1
@export var detecting: bool = false
@export var distance_from_parent: int = 130
#@export var knockback = 50
@export var collision_shape: CollisionShape2D
@export var allow_swivel: bool = false
## Set the reference for this if you want the hitbox to be able to pick up items.
var overlapping_hurtboxes: Array[HurtBox] = []
var successful_hit: Array[HurtBox] = []

func _physics_process(delta):
	if allow_swivel && !detecting:
		move_to (character.get_direction().normalized() * distance_from_parent ) 
		
func move_direction(direction):
	move_to(direction * distance_from_parent)

func move_to(target_position):
	position = target_position
	
func turn_on():
	collision_shape.debug_color = Color (179, 57, 81, .5)
	for area in overlapping_hurtboxes:
		if area is HurtBox: #&& area.detectable && ! (area in successful_hit):
			print("HIT")
			attempt_hit(area)
	detecting = true
	
func turn_off():
	collision_shape.debug_color = Color (145, 199, 177,0)
	successful_hit = []
	detecting = false

func attempt_hit( hurtbox: HurtBox):
	hit(hurtbox)
	return

func hit( hurtbox: HurtBox):
	successful_hit.append(hurtbox)
	hurtbox.hit_by(self)
	
func _on_area_entered(area):
	if area is HurtBox:
		overlapping_hurtboxes.append(area)
		if detecting && area.detectable:
			attempt_hit(area)


func _on_area_exited(area):
	pass # Replace with function body.
