extends StaticBody2D


class_name StoneGate

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var collision_shape: CollisionShape2D = $CollisionShape2D

var state
enum states { IDLE, CLOSE, OPEN }

var is_closed: bool = true
var is_closing: bool = false
var is_opening: bool = false
signal _operation_finished(flag)


func _ready() -> void:
	state = states.IDLE


func _process(_delta: float) -> void:
	match state:
		states.IDLE:
			animated_sprite.play("Idle")
		
		states.CLOSE:
			if not is_closed:
				collision_shape.disabled = false
				animated_sprite.play("Close")
				is_closing = true
				
		states.OPEN:
			if is_closed:
				animated_sprite.play("Open")
				is_opening = true


func open_stone_gate() -> void:
	if is_closed:
		state = states.OPEN
	else:
		emit_signal("_operation_finished", true)


func close_stone_gate() -> void:
	if not is_closed:
		state = states.CLOSE
	else:
		emit_signal("_operation_finished", false)


func _on_AnimatedSprite_animation_finished() -> void:
	if is_closing:
		is_closed = true
		is_closing = false
		emit_signal("_operation_finished", false)
	
	if is_opening:
		is_opening = false
		collision_shape.disabled = true
		is_closed = false
		emit_signal("_operation_finished", true)
		
	if state == states.CLOSE:
		state = states.IDLE
