extends CanvasLayer


var last_played_anim = null
export(Color) var color_dark = Color(14, 17, 25, 255)
export(Color) var color_light = Color(255, 255, 255, 255)


# The flash screen / Logo Screen
onready var LogoScreen = load("res://Scenes/UI/LogoScreen.tscn")


func _ready() -> void:
	change_scene(LogoScreen, "DarkFade")


func change_scene(new_scene, anim = null) -> void:
	if anim:
		reset_color_rect(anim)
		$AnimationPlayer.play(anim)

	var _value = get_tree().change_scene_to(new_scene)
	last_played_anim = anim


func get_anim_duration() -> float:
	if last_played_anim == null:
		return 0.0
	return $AnimationPlayer.get_animation(last_played_anim).length


func reset_color_rect(anim) -> void:
	match anim:
		"DarkFade":
			$ColorRect.color = color_dark
		
		"LightFade":
			$ColorRect.color = color_light
		
		"LevelFade":
			$ColorRect.color = color_light
