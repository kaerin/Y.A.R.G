extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var dmg
var tween_time = 1		#0.3
var green = Color(0.4,0.9,0.4,1.0)
var red = Color(0.9,0.1,0.1,1.0)

func _ready():
	$Label.text = str(dmg)
	$Label.rect_pivot_offset = $Label.rect_size / 2
	$Label.rect_position = -$Label.rect_size / 2
	start_tween()
	#print($Label.get("custom_colors/font_color"))
	if dmg > 0:
		$Label.add_color_override("font_color", red)
	elif dmg < 0:
		$Label.add_color_override("font_color", green)
	

func start_tween():
	$Tween.interpolate_property($Label, 'rect_scale', $Label.rect_scale, Vector2(0,0), tween_time, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()
	
func _on_Tween_tween_completed(object, key):
	queue_free()
