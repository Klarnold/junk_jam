class_name DanceArea extends Area2D


signal pressed
signal released


@export var main_area: bool = false


#var is_presed: bool = false


func _ready() -> void:
	pressed.connect(_on_pressed)
	released.connect(_on_released)


func _on_pressed() -> void:
	print("%s pressed" % name)


func _on_released() -> void:
	print("%s released" % name)
