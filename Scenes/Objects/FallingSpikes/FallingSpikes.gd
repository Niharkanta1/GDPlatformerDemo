extends KinematicBody2D

class_name FallingSpikes

onready var raycast: RayCast2D = $RayCast2D

export(int) var gravity = 1000
export(int) var raycast_length = 50

var is_stuck: bool = true
var velocity: Vector2


func _ready() -> void:
	raycast.cast_to = Vector2(0, raycast_length)


func _physics_process(delta: float) -> void:
	if not is_stuck:
		apply_gravity(delta)
		velocity = move_and_slide(velocity, Vector2.UP)

	# Handle raycast collisions
	if raycast.is_colliding():
		if raycast.collide_with_bodies:
			var collider = raycast.get_collider()
			if collider is Player:
				print("Player Detected")
				is_stuck = false

	# Kinematic body 2d collisions
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var collider = collision.collider
			if collider is TileMap:
				is_stuck = true
			elif collider is Player:
				collider.get_node("StateMachine").transition_to("Death")


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
