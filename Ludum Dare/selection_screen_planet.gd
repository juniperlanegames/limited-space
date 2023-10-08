extends Node2D

var rng = RandomNumberGenerator.new()
var fuel_requirement = 200
var spr: Sprite2D
@export var planet_coordinates: Vector2 
@export var sprites: Array

@onready var fuel_cost: Label = $"CanvasLayer/Panel/VBoxContainer/HBoxContainer3/Fuel Cost"
@onready var planet_sprite: Sprite2D = $PlanetSprite


func _ready() -> void:
	planet_sprite.texture = sprites[randi() % sprites.size()]
	planet_sprite.scale = Vector2(1, 1)
	
	# tween scale with random delay
	var tween = get_tree().create_tween()
	var size = 0.08 + (randf() * 0.04)
	tween.tween_property(planet_sprite, "scale", Vector2(size, size), 3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING).set_delay(randf() * 1.5)
	# color
	planet_sprite.modulate = Color(0,0,0)
	tween = get_tree().create_tween()
	tween.tween_property(planet_sprite, "modulate", Color(light_float(), light_float(), light_float()), 5)
	# rotation
	var dirs = [-1, 1]
	var dir = dirs[randi() % dirs.size()]
	tween = get_tree().create_tween()
	tween.tween_property(planet_sprite, "rotation_degrees", 360.0 * dir, 10 + (randf() * 15)).as_relative()
	tween.set_loops()
		
		
func light_float():
	return (randf() + 1) * 0.5


func _process(delta: float) -> void:
	calculate_fuel_cost()
	fuel_cost.text = str(fuel_requirement)

	
func calculate_fuel_cost():
	# calculate from planet_selection_manager get_cost_to_coordinate(planet_coordinates)
	fuel_requirement = 42
	pass


func _on_button_pressed() -> void:
	print("planet travel button pressed")
