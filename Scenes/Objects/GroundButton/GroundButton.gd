extends StaticBody2D


class_name GroundButton

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var unpressed_collision: CollisionPolygon2D = $UnpressedCollision
onready var pressed_collision: CollisionPolygon2D = $PressedCollision

var is_button_pressd: bool = false
var is_performing_operation: bool = false
var state := 0
var next_state := 0
var gate

func _ready() -> void:
	gate = get_node("StoneGate")
	gate.connect("_operation_finished", self, "_on_operation_finished")
	

func _process(_delta: float) -> void:
	if is_performing_operation:
		return
	
	if state != next_state:
		if next_state == 1:
			state = 1
			press_button()
			
		if next_state == 0:
			state = 0
			unpress_button()


func press_button() -> void:
	unpressed_collision.set_deferred("disabled", true)
	pressed_collision.set_deferred("disabled", false)
	animated_sprite.play("Pressed")
	perform_operation(true)
	

func unpress_button() -> void:
	unpressed_collision.set_deferred("disabled", false)
	pressed_collision.set_deferred("disabled", true)
	animated_sprite.play("Unpressed")
	perform_operation(false)


func perform_operation(flag: bool) -> void:
	if not is_performing_operation:
		is_performing_operation = true
		if flag:
			gate.open_stone_gate()
		else:
			gate.close_stone_gate()


func _on_PressDetector_body_entered(body: Node) -> void:
	if body is RigidBox or body is Player:
		if is_button_pressd == false:
			next_state = 1
			is_button_pressd = true


func _on_PressDetector_body_exited(body: Node) -> void:
	if body is RigidBox or body is Player:
		if is_button_pressd == true:
			next_state = 0
			is_button_pressd = false


func _on_operation_finished(_flag: bool) -> void:
	is_performing_operation = false
