extends KinematicBody2D


class_name Enemy

export(float) var gravity = 1000.0
export(int) var walk_speed = 75

# Handle slopes
export(float) var floor_max_anlge_in_degrees = 65.0
var snap_length: int = 2
var snap_direction: Vector2 = Vector2.DOWN
var snap_vector: Vector2 = snap_direction * snap_length
var floor_max_angle = deg2rad(floor_max_anlge_in_degrees) 

var velocity: Vector2
var direction: String = "right"
var state

var rng = RandomNumberGenerator.new()
var input_direction_x

enum states {
	WALK,
	DEATH
}

func _ready() -> void:
	rng.randomize()
	input_direction_x = 1
	state = states.WALK
	$MoveTimer.start()


func get_random_direction() -> int:
	var random_number = rng.randi_range(0,1)
	return [-1, 1][random_number]


func set_direction_right() -> void:
	direction = "right"
	$AnimatedSprite.flip_h = false


func set_direction_left() -> void:
	direction = "left"
	$AnimatedSprite.flip_h = true


func update_direction(direction_x) -> void:
	if direction_x > 0 :
		set_direction_right()
	elif direction_x < 0 : 
		set_direction_left()


func _physics_process(delta) -> void:
	match state:
		states.WALK:
			$AnimatedSprite.play("Walk")
			update_direction(input_direction_x)
			velocity.x = walk_speed * input_direction_x 
			apply_gravity(delta)
			#velocity = move_and_slide(velocity, Vector2.UP)
			velocity = move_and_slide_with_snap(
				velocity,
				snap_vector,
				Vector2.UP,
				true,
				4,
				floor_max_angle,
				false
			)
			
			# handle collisions
			if get_slide_count() > 0:
				for i in get_slide_count():
					var collision = get_slide_collision(i)
					var collider = collision.collider
					if collider is Player:
						collider.get_node("StateMachine").transition_to("Death")

		states.DEATH:
			$AnimatedSprite.play("Death")
			$CollisionShape2D.disabled = true
			yield($AnimatedSprite, "animation_finished")
			queue_free()


func apply_gravity(delta) -> void:
	velocity.y += gravity * delta


func _on_MoveTimer_timeout() -> void:
	# MoveTimer is timedout Signal
	input_direction_x = get_random_direction()


func _on_HurtBox_area_entered(area: Area2D) -> void:
	# check the area (attack) is actually the player 
	if area.owner is Player:
		state = states.DEATH
