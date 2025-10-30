extends RichTextLabel

var timer = 0.0



# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 120
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	text = " Time: " + str(int(timer))
	if (timer < 0.5):
		timer_ended()
	pass
func timer_ended():
	get_node("../EndUI").position.x = 0
	get_tree().paused = true
	pass
