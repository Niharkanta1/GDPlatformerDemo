extends Control

var next_scene: String = "res://Scenes/UI/TitleScreen.tscn"
var music_vol_range: float
var sound_effect_vol_range: float
onready var music_scroll_bar: HScrollBar = $VBoxContainer/MusicScrollBar
onready var sound_effect_scroll_bar: HScrollBar = $VBoxContainer/SoundEffectScrollBar


func _ready() -> void:
	music_vol_range = get_scroll_bar_range_value(music_scroll_bar.min_value, music_scroll_bar.max_value)
	sound_effect_vol_range = get_scroll_bar_range_value(sound_effect_scroll_bar.min_value, sound_effect_scroll_bar.max_value)
	if not SoundManager.title_screen_music.playing:
		SoundManager.title_screen_music.play()
	if SoundManager.music_scroll_vol_current != null:
		music_scroll_bar.value = SoundManager.music_scroll_vol_current
	if SoundManager.sound_effect_scroll_vol_current != null:
		sound_effect_scroll_bar.value = SoundManager.sound_effect_scroll_vol_current


func get_scroll_bar_range_value(min_value, max_value) -> float:
	return (max_value - min_value)/2


func _on_Button_button_down():
	SoundManager.button_sound.play()


func _on_Button_button_up():
	var _res = get_tree().change_scene(next_scene)


func _on_MusicScrollBar_scrolling():
	SoundManager.update_sound_volume(music_scroll_bar.value, music_vol_range, "Music")


func _on_SoundEffectScrollBar_scrolling():
	SoundManager.update_sound_volume(sound_effect_scroll_bar.value, music_vol_range, "SoundEffects")
