extends Control
class_name CircularCover_ScreenSpaceEffects_BRK

@onready var effect := $Effect

var cover_center : Vector2 :
	set(value): effect.material.set_shader_parameter("cover_center", value)
	get: return effect.material.get_shader_parameter("cover_center")

var cover_scatter_intensity : float :
	set(value): effect.material.set_shader_parameter("cover_scatter_intensity", value)
	get: return effect.material.get_shader_parameter("cover_scatter_intensity")

var cover_size : float :
	set(value): effect.material.set_shader_parameter("cover_size", value)
	get: return effect.material.get_shader_parameter("cover_size")

var cover_color : float :
	set(value): effect.material.set_shader_parameter("cover_color", value)
	get: return effect.material.get_shader_parameter("cover_color")

static func new():
	var resource := load("circular_cover.tscn")
	return resource.instantiate()


func cover(target_cover_scatter_intensity := 0.0, target_cover_size := 0.0, tween_duration := 0.5):
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "cover_size", target_cover_size, tween_duration) 
	tween.tween_property(self, "cover_scatter_intensity", target_cover_scatter_intensity, tween_duration)
	await tween.finished

func clear():
	await cover(1, 0)
