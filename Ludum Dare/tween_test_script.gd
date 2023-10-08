extends Node

@export var godot_sprite: Sprite2D
var speed = 100


func _init() -> void:
	print("initt")

func _ready() -> void:
	godot_sprite.position = Vector2(575,325) # (575,325) = middle
	
	for y in range(7):
		# create planet
		var new_planet = godot_sprite.duplicate()
		add_child(new_planet)
		# set position & scale
		new_planet.position = Vector2(randf() * 1100, 200)
		new_planet.scale = Vector2(20, 20)
		# tween scale with random delay
		var tween = get_tree().create_tween()
		tween.tween_property(new_planet, "scale", Vector2(1,1), 3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_delay(randf() * 1.5)
		# color
		new_planet.modulate = Color(0,0,0)
		tween = get_tree().create_tween()
		tween.tween_property(new_planet, "modulate", Color(light_float(), light_float(), light_float()), 5)
		# rotation
		var dirs = [-1, 1]
		var dir = dirs[randi() % dirs.size()]
		tween = get_tree().create_tween()
		tween.tween_property(new_planet, "rotation_degrees", 360.0 * dir, 10 + (randf() * 15)).as_relative()
		tween.set_loops()
		
	
#	var tween = get_tree().create_tween()
#	tween.tween_property(godot_sprite, "modulate", Color.RED, 1)
#	tween.tween_property(godot_sprite, "scale", Vector2(), 1)
#	tween.tween_callback(godot_sprite.queue_free)
	
	
func light_float():
	return (randf() + 1) * 0.5
	
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_RIGHT):
		godot_sprite.move_local_x(speed * delta)
	elif Input.is_key_pressed(KEY_LEFT):
		godot_sprite.move_local_x(-speed * delta)
