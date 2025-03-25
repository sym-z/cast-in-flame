extends Node2D

var details : StructureDetails

func _ready():
	details = StructureDetails.new()
	details.size = Vector2i(4,4)
