class_name DanceGrid extends Node2D


@export var dance_areas_array: Dictionary[Vector2i, DanceArea]


@onready var _search_area: SearchArea = %SearchArea


var search_area_id: Vector2i = Vector2i.ZERO:
	set = set_search_area_id


func _ready() -> void:
	_search_area.global_position = dance_areas_array[Vector2i.ZERO].global_position


func set_search_area_id(new_search_area_id: Vector2i) -> void:
	if dance_areas_array.has(new_search_area_id):
		search_area_id = new_search_area_id
		_search_area.global_position = dance_areas_array[search_area_id].global_position


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("dance"):
			_search_area.pressed.emit()
		elif event.is_action_released("dance"):
			_search_area.released.emit()
		else:
			var new_search_area_id: Vector2i = Input.get_vector("move_left", "move_right", "move_up", "move_down").sign()
			
			search_area_id = new_search_area_id
