extends Area2D


class_name Door

export var next_scene: PackedScene

func _ready() -> void:
	pass



func _on_Door_body_entered(body: Node) -> void:
	if body is Player:
		if next_scene != null:
			SceneManager.change_scene(next_scene, "LightFade")
