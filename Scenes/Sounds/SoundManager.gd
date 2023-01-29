extends Node2D

# Singleton


# Music
onready var music_list : Node = $Music
onready var title_screen_music : AudioStreamPlayer = $Music/TitleScreenMusic
onready var gameplay_music : AudioStreamPlayer = $Music/GameplayMusic
onready var ending_music : AudioStreamPlayer = $Music/EndingMusic

# Sound Effects
onready var sound_effect_sound : Node = $SoundEffects
onready var attack_sound : AudioStreamPlayer = $SoundEffects/AttackSound
onready var button_sound : AudioStreamPlayer = $SoundEffects/ButtonSound
onready var dash_sound : AudioStreamPlayer = $SoundEffects/DashSound
onready var death_sound : AudioStreamPlayer = $SoundEffects/DeathSound
onready var jump_sound : AudioStreamPlayer = $SoundEffects/JumpSound
onready var land_sound : AudioStreamPlayer = $SoundEffects/LandSound
onready var level_completed_sound : AudioStreamPlayer = $SoundEffects/LevelCompletedSound
onready var logo_sound : AudioStreamPlayer = $SoundEffects/LogoSound


func _ready() -> void:
	pass


func update_sound_volume(_volume, _volume_range, type):
	match type:
		"Music":
			pass
		
		"SoundEffects":
			pass


func stop_all_music(): 
	for i in music_list.get_child_count():
		var music = music_list.get_child(i) as AudioStreamPlayer
		if music.playing:
			music.stop()
