extends Particles2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction = Vector2(0,0)
var particle_count = 0

func _ready():
	emitting = true
	one_shot = false
	$Timer.wait_time = 5
	$Timer.start()
	
	if direction == Vector2(0,0):		#if no direction vector spread blood in all directions. eg. AOE effects.
		process_material.spread = 180
	else:
		rotation_degrees = rad2deg(direction.angle())
		
	amount = particle_count

func _on_Timer_timeout():
	queue_free()
