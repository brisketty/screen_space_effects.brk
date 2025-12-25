extends Node
class_name Distortions_ScreenSpaceEffects_BRK


func play(position: Vector2, size: float, duration := 0.7 , force := 0.1, thickness := .0, backward := false):
	for distortion in get_children():
		if distortion is Distortion_ScreenSpaceEffects_BRK and not distortion.is_playing:
			await distortion.play(position, size, duration, force, thickness, backward)
			return
	var distortion := Distortion_ScreenSpaceEffects_BRK.get_packed_scene().instantiate() as Distortion_ScreenSpaceEffects_BRK
	add_child(distortion)
	await distortion.play(position, size, duration, force, thickness, backward)
