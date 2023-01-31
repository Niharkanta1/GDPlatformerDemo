extends KinematicBody2D

class_name Player

onready var animation_state = $AnimationTree.get("parameters/playback")
onready var player_collider = $CollisionShape2D
onready var raycast = $RayCast2D

# Player variables
export(float) var gravity = 1000.0
export(int) var jump_speed = -300
export(int) var walk_speed = 75
export(int) var dash_speed = 300
export(int) var num_dashes = 1

export(Vector2) var rigid_push = Vector2(225, 0)

# Handle slopes
export(float) var floor_max_anlge_in_degrees = 65.0
var snap_length: int = 2
var snap_direction: Vector2 = Vector2.DOWN
var snap_vector: Vector2 = snap_direction * snap_length
var floor_max_angle = deg2rad(floor_max_anlge_in_degrees) 

var velocity: Vector2
var direction = "right"
var is_attacking = false
var is_dashing = false

var state
enum states {
	IDLE, WALK, FALL, JUMP, ATTACK, DASH, DEATH
}


func _ready() -> void:
	state = states.IDLE
	#get_node("HitboxPosition/Hitbox/CollisionShape2D").disabled = true


func update_direction(input_direction_x: float) -> void:
	if input_direction_x > 0:
		set_direction_right()
	elif input_direction_x < 0:
		set_direction_left()


func set_direction_right() -> void:
	direction = "right"
	$Sprite.flip_h = false
	$HitboxPosition.rotation_degrees = 0


func set_direction_left() -> void:
	direction = "left"
	$Sprite.flip_h = true
	$HitboxPosition.rotation_degrees = 180	


func apply_gravity(delta) -> void:
	velocity.y += gravity * delta


func on_attack_finished() -> void:
	is_attacking = false	


func on_dash_finished() -> void:
	is_dashing = false


func reset_dash_counter(value: int) -> void:
	num_dashes = value


func has_dashes() -> bool:
	if num_dashes > 0:
		return true
	return false


func play_death_sound() -> void:
	SoundManager.death_sound.play()
	

func restart_level() -> void:
	var current_level = get_parent().get_parent().name
	# General path res://Scenes/Levels/Level1.tscn
	var path = "res://Scenes/Levels/"+current_level+".tscn"
	var current_scene = load(path)
	SceneManager.change_scene(current_scene, "LevelFade")
