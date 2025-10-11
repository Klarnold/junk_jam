class_name DanceArea extends Area2D


signal pressed
signal released


@export var main_area: bool = false
@export var texture: Texture = preload("uid://3smmy2u8b5q1") # basic_dance_area.aseprite

var inner_areas: Array[Area2D]


@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready() -> void:
	pressed.connect(_on_pressed)
	released.connect(_on_released)
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	sprite_2d.texture = texture


func _on_pressed() -> void:
	print("pressed")
	for note in inner_areas:
		if note is BasicNote:
			note.pressed()


func _on_released() -> void:
	for note in inner_areas:
		if note is BasicNote:
			note.released()


func _on_area_entered(area: Area2D) -> void:
	if area is BasicNote:
		print("area entered")
		inner_areas.append(area)

func _on_area_exited(area: Area2D) -> void:
	if area is BasicNote:
		print("EXITED")
		inner_areas.erase(area)
