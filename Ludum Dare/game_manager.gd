class_name GameManager extends Node  # adds to global scope

enum GameState {
	MAIN_MENU = 0,
	PLANET_SELECTION,
	DRONE_PHASE,
	SELL_PHASE,
}
static var state: GameState = GameState.MAIN_MENU

@onready var planets_selection_manager: Node = $"../PlanetsSelectionManager"
@onready var cargo_space: Node2D = $"../../CargoSpace"
@onready var game_manager: Node = $"."

static var I  # singleton instance (i for short)


func _init() -> void:
	pass

func _ready() -> void:
	I = game_manager
	pass 

func _process(delta: float) -> void:
	pass
	

func start_game():
	_cargo_set_visible(false)
	planets_selection_manager.spawn_planets()
	state = GameState.PLANET_SELECTION
	


func start_planet_gameplay():
	planets_selection_manager.hide_planets()
	_cargo_set_visible(true)
	state = GameState.DRONE_PHASE


## helper functions ##

func _cargo_set_visible(visibility):
	cargo_space.visible = visibility
	cargo_space.get_node("CanvasLayer").visible = visibility
	pass
