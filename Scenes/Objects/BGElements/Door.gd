extends Area2D


class_name Door

export var next_scene: PackedScene

func _ready() -> void:
	pass



func _on_Door_body_entered(body: Node) -> void:
	if body is Player:
		pass # handle transition to next scene
