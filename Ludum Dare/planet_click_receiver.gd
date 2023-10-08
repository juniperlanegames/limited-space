extends Sprite2D 
class_name PlanetClickReceiver

var id
static var selected_planet: PlanetClickReceiver
@export var sprite: Sprite2D 
var small_size = Vector2.ZERO
var is_active: bool = false;

func _ready() -> void:
	id = randi()
	# wait time before clicks can be received
	var timer = Timer.new()
	timer.connect("timeout", _on_timer_timeout_activation_timer)
	timer.wait_time = 4.5 # size tween time + max delay
	add_child(timer)
	timer.start()


func _on_timer_timeout_activation_timer():
	is_active = true


func _process(delta: float) -> void:
	pass


func _unhandled_input(event):
	if !is_active:
		return
		
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
		if small_size == Vector2.ZERO:
			small_size = sprite.scale
		var gtm = get_global_transform()  # global transform matrix
		var gp = gtm.get_origin() # global position
		
		var this_planet = false
		
		if get_local_mouse_position().length() < 280:
			this_planet = true
			selected_planet = self
		
		var tween = get_tree().create_tween()
		if !this_planet:
			tween.tween_property(sprite, "scale", small_size, 0.5)
		else:
			tween.tween_property(sprite, "scale", Vector2(0.2, 0.2), 0.5)
			

#func _unhandled_input(event):
#	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
#		print(event.position)
#		var gtm = get_global_transform()  # global transform matrix
#		var gp = gtm.get_origin() # global position
##		var pos = (gp + offset - ( (texture.get_size() / 2.0)) if centered else Vector2() )
#		if Rect2(gp + Vector2(+150, 0), Vector2(100, 100)).has_point(event.position):
#			print(gtm.get_origin())
