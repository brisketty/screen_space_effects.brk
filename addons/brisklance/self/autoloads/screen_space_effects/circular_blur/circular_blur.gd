extends Control
class_name CircularBlur_ScreenSpaceEffects_BRK

@onready var effect := $Effect

var blur_center : Vector2 :
	set(value): effect.material.set_shader_parameter("blur_center", value)
	get: return effect.material.get_shader_parameter("blur_center")

var blur_scatter_intensity : float :
	set(value): effect.material.set_shader_parameter("blur_scatter_intensity", value)
	get: return effect.material.get_shader_parameter("blur_scatter_intensity")

var blur_size : float :
	set(value): effect.material.set_shader_parameter("blur_size", value)
	get: return effect.material.get_shader_parameter("blur_size")

var blur_intensity : float :
	set(value): effect.material.set_shader_parameter("blur_intensity", value)
	get: return effect.material.get_shader_parameter("blur_intensity")

static func new():
	var resource := load("circular_blur.tscn")
	return resource.instantiate()

func blur(target_blur_size := 0.3, target_blur_intensity := 3.0, target_blur_scatter_intensity := 0.8, tween_duration := 0.5):
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "blur_size", target_blur_size, tween_duration) 
	tween.tween_property(self, "blur_intensity", target_blur_intensity, tween_duration)
	tween.tween_property(self, "blur_scatter_intensity", target_blur_scatter_intensity, tween_duration)
	await tween.finished

func clear():
	await blur(1, 0, 0)
