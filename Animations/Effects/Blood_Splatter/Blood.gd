extends Particles2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction = Vector2(0,0)

func _ready():
	emitting = true
	one_shot = true
	$Timer.wait_time = 0.5
	
	if direction == Vector2(0,0):		#if no direction vector spread blood in all directions. eg. AOE effects.
		process_material.spread = 180
	else:
		rotation_degrees = rad2deg(direction.angle())

func _on_Timer_timeout():
	queue_free()
