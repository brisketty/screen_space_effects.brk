extends CanvasLayer

@export_group("Nodes", "node_")
@export var node_blur : CircularBlur_ScreenSpaceEffects_BRK
@export var node_cover : CircularCover_ScreenSpaceEffects_BRK
@export var node_distortions : Distortions_ScreenSpaceEffects_BRK
@export var node_mouse_blocker : Control

var is_blocking_mouse := false :
	set(p_value):
		is_blocking_mouse = p_value
		update_from_is_blocking_mouse()

var is_transitioning := false

func update_from_is_blocking_mouse() -> void:
	node_mouse_blocker.mouse_filter = (
		Control.MouseFilter.MOUSE_FILTER_STOP if is_blocking_mouse else 
		Control.MouseFilter.MOUSE_FILTER_IGNORE
	)

func transition_scene_to_packed(p_packed_scene: PackedScene, p_duration := 1.0) -> void:
	if is_transitioning: return
	is_transitioning = true
	is_blocking_mouse = true
	
	var original_cover_size := node_cover.cover_size
	var original_cover_scatter_intensity := node_cover.cover_scatter_intensity
	await node_cover.cover(0.0, 0.0, p_duration / 2)
	get_tree().change_scene_to_packed(p_packed_scene)
	await get_tree().scene_changed
	await node_cover.cover(original_cover_scatter_intensity, original_cover_size, p_duration / 2)
	
	is_blocking_mouse = false
	is_transitioning = false

func transition_scene_to_file(p_path : String, p_duration := 1.0) -> void:
	await transition_scene_to_packed(load(p_path), p_duration)

func _ready() -> void:
	update_from_is_blocking_mouse()
