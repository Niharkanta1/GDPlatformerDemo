extends PlayerState


func enter() -> void:
	player.animation_state.travel("Push")
	

func exit() -> void:
	pass
	

func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
			return
	
	var input_direction_x: float = (
		Input.get_action_strength("ui_right")
		- Input.get_action_strength("ui_left")
	)
	
	if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"):
		if player.direction == "right":
			input_direction_x = 1
		else:
			input_direction_x = -1

	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide_with_snap(
		player.velocity,
		player.snap_vector,
		Vector2.UP,
		true,
		4,
		player.floor_max_angle,
		false
	)
	
	# Handle Collisions Here
	if player.get_slide_count() > 0:
		for i in player.get_slide_count():
			var collision = player.get_slide_collision(i)
			var box = collision.collider
			if box is RigidBox:
				box.apply_central_impulse(-collision.normal * player.rigid_push)
	
	
	# Handle Other Transisions
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("Dash")
			

