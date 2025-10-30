extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Vector2(-100000, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_2_pressed():
	global_position = Vector2(0, 0)
	pass # Replace with function body.


func _on_button_pressed():
	global_position = Vector2(-100000, 0)
	pass # Replace with function body.
