extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var a := false
	
	for i in 10:
		await get_tree().create_timer(1).timeout
		ScreenSpaceEffects.node_distortions.play(Vector2.ZERO, 1)
		ScreenSpaceEffects.node_cover.cover(0.5, 0.4 if a else 0.0)
		ScreenSpaceEffects.node_blur.blur(0.2, 0.7 if a else 0.0)
		a = not a
