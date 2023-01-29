extends RigidBody2D


class_name RigidBox

export(float) var max_speed = 20.0

func _ready() -> void:
	pass


func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	if self.linear_velocity.length() > max_speed:
		var direction = self.linear_velocity.normalized()
		self.linear_velocity = direction * max_speed