extends ParallaxBackground



func _ready():
	visible = true


func _process(delta):
	scroll_base_offset += Vector2(1,-2) * delta

func _exit_tree():
	visible = false
