extends TextureRect


export var next_scene: PackedScene
var duration: int = 1


func _ready() -> void:
	SoundManager.stop_all_music()
	SoundManager.logo_sound.play()
	$Timer.wait_time = SceneManager.get_anim_duration() + duration
	$Timer.start()


func _on_Timer_timeout() -> void:
	SceneManager.change_scene(next_scene, "LightFade")
