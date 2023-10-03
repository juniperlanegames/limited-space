extends TextureRect

@export var randomize_color = false
@export var randomize_texture = false
@export var textures: Array = []

func _ready() -> void:
	if randomize_texture:
		self.texture = textures[randi() % textures.size()]
		
	if randomize_color:
		self.modulate = Color(randf(), randf(), randf())
