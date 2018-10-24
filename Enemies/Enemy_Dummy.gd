extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction = Vector2()
var speed = 0
const MAX_SPEED = 200
var velocity = Vector2()
var is_moving = false
var target_pos = Vector2()
var target_direction = Vector2()
var enemy

func _ready():
	$Name.text = enemy.base_name

func _process(delta):
	if is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction.normalized() * delta
		move_and_collide(velocity)

		var pos = get_position()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			is_moving = false
	#		rpc('sync_move', target_pos)
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			is_moving = false
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

remote func sync_move(pos, dir):
	target_pos = pos
	target_direction = dir
	is_moving = true
	
