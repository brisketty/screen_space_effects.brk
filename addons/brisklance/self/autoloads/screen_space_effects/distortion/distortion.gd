extends Control
class_name Distortion_ScreenSpaceEffects_BRK

@export var distortion_mark : Marker2D
@export var effect : ColorRect

var is_playing := false

var distortion_center : Vector2 :
	set(value): effect.material.set_shader_parameter("distortion_center", value)
	get: return effect.material.get_shader_parameter("distortion_center")

var distortion_force : float :
	set(value): effect.material.set_shader_parameter("distortion_force", value)
	get: return effect.material.get_shader_parameter("distortion_force")

var distortion_size : float :
	set(value): effect.material.set_shader_parameter("distortion_size", value)
	get: return effect.material.get_shader_parameter("distortion_size")

var distortion_thickness : float :
	set(value): effect.material.set_shader_parameter("distortion_thickness", value)
	get: return effect.material.get_shader_parameter("distortion_thickness")

static func get_packed_scene() -> PackedScene:
	return preload("./distortion.tscn") as PackedScene

func _process(_delta):
	if distortion_mark == null or not distortion_mark is Node2D: return
	if get_viewport().get_camera_2d() == null: return
	var uv_position = get_viewport().get_camera_2d().get_canvas_transform() * distortion_mark.global_position / get_viewport_rect().size
	uv_position.y = 1 - uv_position.y
	distortion_center = uv_position

func play(target_position: Vector2, target_size: float, duration := 0.7 , force := .5, thickness := .0, backward := false):
	if not is_node_ready(): await ready
	distortion_mark.global_position = target_position
	distortion_force = force if not backward else 0.0
	distortion_size = 0.0 if not backward else target_size
	distortion_thickness = thickness if not backward else 0.0
	is_playing = true
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "distortion_force", 0.0 if not backward else force, duration)
	tween.tween_property(self, "distortion_size", target_size if not backward else 0.0, duration)
	tween.tween_property(self, "distortion_thickness", 0.0 if not backward else thickness, duration)
	await tween.finished
	is_playing = false
