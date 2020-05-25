extends Control

onready var tolleranza
onready var corsa
onready var get_value = Vector2(0,0)
onready var _handle := $centro

onready var _start_position = $centro.position
onready var _start_global = $centro.global_position

export(int, 0, 16) var direzioni := 0
export(float, 0, 1) var alfa := 0.4

#0 = Multidirezionali
#1 = 2 assi verticali
#2 = 2 assi orizzonatali
#4 = 4 assi
#N = N assi

func _ready():
	tolleranza = 0.3 * $esterno.texture.get_size().x / 2
	corsa = $esterno.texture.get_size().x / 2
	modulate = Color(1,1,1,alfa) 

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var temp = (_start_global - event.position).clamped(corsa)
		if temp.length() > tolleranza:
			get_value = temp
			if direzioni > 0:
				get_value = _directional_vector(get_value, direzioni)
			_handle.position = -get_value
		else:
			get_value = _start_position
			_handle.position = _start_position

	if event is InputEventScreenTouch and !event.is_pressed():
		get_value = _start_position
		_handle.position = _start_position

func output():
	return (get_value / corsa) 

func _directional_vector(vector: Vector2, n_directions: int) -> Vector2:
	var simmetry_angle := PI
	if n_directions == 1:
		simmetry_angle = PI/2
		n_directions = 2
# warning-ignore:integer_division
	n_directions = int(n_directions / 2) * 2
	var angle := (vector.angle() + simmetry_angle) / (PI / n_directions)
	angle = floor(angle) if angle >= 0 else ceil(angle)
	if abs(angle) as int % 2 == 1:
		angle = angle + 1 if angle >= 0 else angle - 1
	angle *= PI / n_directions
	angle -= simmetry_angle
	return Vector2(cos(angle), sin(angle)) * vector.length()
