extends Position2D


export(int) var rotation_speed = 50
export(bool) var left = false
export(bool) var right = false
export(bool) var up = false
export(bool) var down = false


var starting_rotation
var ending_rotation
var direction: int = 1


func _ready() -> void:
	if left:
		starting_rotation = 0
		ending_rotation = 180

	elif up:
		starting_rotation = 90
		ending_rotation = 270

	elif right:
		starting_rotation = 180
		ending_rotation = 360

	elif down:
		starting_rotation = -90
		ending_rotation = 90
	
	self.rotation_degrees = starting_rotation

	
func _physics_process(delta: float) -> void:
	if self.rotation_degrees < starting_rotation:
		direction = 1
	elif self.rotation_degrees > ending_rotation:
		direction = -1

	self.rotation_degrees += rotation_speed * direction * delta
