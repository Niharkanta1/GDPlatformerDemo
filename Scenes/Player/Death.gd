extends PlayerState


func enter() -> void:
	player.animation_state.travel("Death")

func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
