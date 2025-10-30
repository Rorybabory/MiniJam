extends Node2D

var counter = 0
var target_count = 1

var creature = preload("res://creature.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	target_count = randf_range(10, 17)
	pass # Replace with function body.

func spawn():
	var inst = creature.instantiate()
	get_node("./").add_child(inst)
	inst.global_position.x = global_position.x + randf_range(-40, 40)
	inst.global_position.y = global_position.y + randf_range(-40, 40)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter+=delta
	if (counter > target_count):
		print("spawn")
		target_count = randf_range(8, 13)
		counter = 0
		spawn()
		pass
	pass
