@tool
extends EditorPlugin
class_name EditorPlugin_ScreenSpaceEffect_BRK

const SCREEN_SPACE_EFFECTS_AUTOLOAD_RESOURCE_PATH := "./autoloads/screen_space_effects/screen_space_effects.tscn"
const SCREEN_SPACE_EFFECTS_AUTOLOAD_NAME := "ScreenSpaceEffects"


func _enable_plugin() -> void:
	# Add autoloads here.
	add_autoload_singleton(SCREEN_SPACE_EFFECTS_AUTOLOAD_NAME, SCREEN_SPACE_EFFECTS_AUTOLOAD_RESOURCE_PATH)
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	remove_autoload_singleton(SCREEN_SPACE_EFFECTS_AUTOLOAD_NAME)
	pass


func _enter_tree() -> void:
	pass


func _exit_tree() -> void:
	pass
