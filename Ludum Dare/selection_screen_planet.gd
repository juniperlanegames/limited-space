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
	planet_sprite.modulate = Color(randf(), randf(), randf())
	

func _process(delta: float) -> void:
	calculate_fuel_cost()
	fuel_cost.text = str(fuel_requirement)

	
func calculate_fuel_cost():
	# calculate from planet_selection_manager get_cost_to_coordinate(planet_coordinates)
	fuel_requirement = 42
	pass


func _on_button_pressed() -> void:
	print("planet travel button pressed")
