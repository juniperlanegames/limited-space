extends Node

var rng = RandomNumberGenerator.new()
@export var all_planets_list: Array
var planets: Array
var planet_amount_in_grid: int = 6
var planet_types_amount: int = 3
var planet_grid_rows: int = 4
var planet_grid_columns: int = 6
var planet_distance_px: int = 150
var grid_y_offset_px: int = -100

#@export var planet: Node


func _ready() -> void:
	planets = create_2d_array(planet_grid_columns, planet_grid_rows, 0)
		
	while get_planet_amount() < 6:
		_add_planet()
	
#	print(planets)

	
func _add_planet():
	var x_column = 0
	var y_row = 0
	var planet = 0
	
	planet = rng.randi_range(1, planet_types_amount)
	x_column = rng.randi_range(0, planet_grid_columns - 1)
	y_row = rng.randi_range(0, planet_grid_rows - 1)
	
	planets[y_row][x_column] = planet
	pass
	

func get_planet_amount():
	var counter = 0
	for y in range(planet_grid_rows):
		for x in range(planet_grid_rows):
			if planets[y][x] > 0:
				counter += 1
		
#	print(counter, " planets")
	return counter

func _process(delta: float) -> void:
	pass

func spawn_planets():
	for y in range(planet_grid_rows):
		for x in range(planet_grid_rows):
			if planets[y][x] > 0:
				spawn_single_planet(grid_y_offset_px + x * planet_distance_px,grid_y_offset_px + y * planet_distance_px)
				

func spawn_single_planet(x, y):
	var planet = preload("res://planet_selection.tscn")
	var p = planet.instantiate()
	p.position.x = x
	p.position.y = y
	add_child(p)


func hide_planets():
	for _i in self.get_children():
		_i.visible = false
		

func show_planets():
	for _i in self.get_children():
		_i.visible = true


static func create_2d_array(width, height, default_value):
	var a = []

	# create row
	for y in range(height):
		a.append([])
		a[y].resize(width)

		# fill row with default value
		for x in range(width):
			a[y][x] = default_value

	return a
