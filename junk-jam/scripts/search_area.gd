class_name SearchArea extends Area2D

signal pressed
signal released


func _ready() -> void:
	pressed.connect(_on_pressed)
	released.connect(_on_released)


func _on_pressed() -> void:
	var dance_areas: Array = get_overlapping_areas()
	print("SEARCH AREA pressed")
	for dance_area in dance_areas:
		if dance_area is DanceArea:
			dance_area.pressed.emit()


func _on_released() -> void:
	var dance_areas: Array = get_overlapping_areas()
	print("SEARCH AREA released")
	for dance_area in dance_areas:
		if dance_area is DanceArea:
			dance_area.released.emit()
