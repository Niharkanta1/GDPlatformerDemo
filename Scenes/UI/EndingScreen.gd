extends Control


var next_scene: PackedScene = SceneManager.LogoScreen
var counter: int = 0
var scroll_speed: int = 10

var credit_list = [
	["Game Director", "Nihar"],
	["Programmer", "Nihar"],
	["Art", "From itch.io"],
	["Animation", "itch.io"],
	["Level Design", "Nihar"],
	["Music", "..Sound artists"],
	["Sound Effects", "..Sound artists"],
	["Fonts", "..Font source goes here"],
	["Softwares", "... Different software goes here"],
	["Thank You!", "Nihar"],
	["", ""]
]

func _ready():
	SoundManager.stop_all_music()
	SoundManager.ending_music.play()
	$Timer.start()


func _process(delta):
	$ParallaxBackground/ParallaxLayer.motion_offset.x -= scroll_speed * delta


func _on_Timer_timeout():
	$VBoxContainer/Title.text = credit_list[counter][0]
	$VBoxContainer/Name.text = credit_list[counter][1]
	$AnimationPlayer.play("FadeInOut")
	counter += 1
	if counter == credit_list.size():
		$Timer.stop()
		SceneManager.change_scene(next_scene, "DarkFade")
	
