extends Node2D

# Singleton


# Music
onready var music_list : Node = $Music
onready var title_screen_music : AudioStreamPlayer = $Music/TitleScreenMusic
onready var gameplay_music : AudioStreamPlayer = $Music/GameplayMusic
onready var ending_music : AudioStreamPlayer = $Music/EndingMusic

# Sound Effects
onready var sound_effects_list : Node = $SoundEffects
onready var attack_sound : AudioStreamPlayer = $SoundEffects/AttackSound
onready var button_sound : AudioStreamPlayer = $SoundEffects/ButtonSound
onready var dash_sound : AudioStreamPlayer = $SoundEffects/DashSound
onready var death_sound : AudioStreamPlayer = $SoundEffects/DeathSound
onready var jump_sound : AudioStreamPlayer = $SoundEffects/JumpSound
onready var land_sound : AudioStreamPlayer = $SoundEffects/LandSound
onready var level_completed_sound : AudioStreamPlayer = $SoundEffects/LevelCompletedSound
onready var logo_sound : AudioStreamPlayer = $SoundEffects/LogoSound

# Scroll bar properties
var music_scroll_vol_current = null
var sound_effect_scroll_vol_current = null
var previous_music_vol_incr = 0
var previous_sound_effects_vol_incr = 0


func _ready() -> void:
	pass


func update_sound_volume(value, volume_range, type):
	match type:
		"Music":
			for i in music_list.get_child_count():
				var music = music_list.get_child(i)
				music.volume_db += value - volume_range - previous_music_vol_incr
				
			previous_music_vol_incr = value - volume_range
			music_scroll_vol_current = value
		
		"SoundEffects":
			for i in sound_effects_list.get_child_count():
				var sound_effect = sound_effects_list.get_child(i)
				sound_effect.volume_db += value - volume_range - previous_sound_effects_vol_incr

			previous_sound_effects_vol_incr = value - volume_range
			sound_effect_scroll_vol_current = value


func stop_all_music(): 
	for i in music_list.get_child_count():
		var music = music_list.get_child(i) as AudioStreamPlayer
		if music.playing:
			music.stop()
