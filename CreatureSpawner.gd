extends Node2D

var creature = preload("res://creature.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():

	for n in range(4):
		var inst = creature.instantiate()
		inst.global_position.x = randf_range ( -500, 500 )
		inst.global_position.y = randf_range ( -300, 300 )
		get_node("./").add_child(inst)
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
