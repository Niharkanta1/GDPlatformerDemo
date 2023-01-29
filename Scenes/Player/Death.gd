extends PlayerState


func enter() -> void:
	player.animation_state.travel("Death")
	player.player_collider.disabled = true

func exit() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	pass
