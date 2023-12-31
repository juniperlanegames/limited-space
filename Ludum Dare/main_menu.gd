extends Control

@onready var cl_main_menu: CanvasLayer = $"CL MainMenu"
@onready var cl_planet_selection: CanvasLayer = $"CL Planet Selection"
@onready var cl_planet_gameplay: CanvasLayer = $"CL Planet Gameplay"
@onready var control_main_menu: Control = $"."


func _ready():
	cl_main_menu.visible = true
	$"CL MainMenu/ParallaxBackground".visible = true
	cl_planet_selection.visible = false
	$"CL Planet Selection/ParallaxBackground".visible = false
	cl_planet_gameplay.visible = false

func _on_button_pressed() -> void: # play button
	$"CL MainMenu/PlayButton/PlayButtonTimer".start()

func _on_play_button_timer_timeout():
	cl_main_menu.visible = false
	$"CL MainMenu/ParallaxBackground".visible = false
	cl_planet_selection.visible = true
	$"CL Planet Selection/ParallaxBackground".visible = true
	GameManager.I.start_game()
	
	var timer = Timer.new()
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = 9999
	add_child(timer)
	timer.start()
	
	
func go_to_planet_ui():
	cl_planet_selection.visible = true
	cl_planet_gameplay.visible = true

func _on_timer_timeout():
	go_to_planet_ui()
	GameManager.I.start_planet_gameplay()




