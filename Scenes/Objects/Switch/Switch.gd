extends Area2D

class_name Switch

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

var gate
var is_switch_open = false
var is_performing_operation = false


func _ready() -> void:
	gate = get_node("StoneGate")
	gate.connect("_operation_finished", self, "_on_operation_finished")


func _on_Switch_area_entered(area: Area2D) -> void:
	if area.owner is Player and not is_performing_operation:
		if not is_switch_open:
			animated_sprite.play("Open")
			perform_operation(true)
		else:
			animated_sprite.play("Close")
			perform_operation(false)
		
		is_switch_open = !is_switch_open
		is_performing_operation = true


func perform_operation(flag: bool) -> void:
	if flag:
		gate.open_stone_gate()
	else:
		gate.close_stone_gate()
		

func _on_operation_finished(flag: bool) -> void:
	is_performing_operation = false
