extends TextureButton



func _on_mouse_entered():
	$AnimatedSprite2D.play("hover")



func _on_mouse_exited():
	$AnimatedSprite2D.play("normal")



func _on_pressed():
	$AnimatedSprite2D.play("pressed")
