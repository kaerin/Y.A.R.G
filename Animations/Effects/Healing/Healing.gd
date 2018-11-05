extends Particles2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var duration = 0

func _ready():
	emitting = true
	one_shot = false
	$Timer.wait_time = duration
	
func _on_Timer_timeout():
	queue_free()