class_name DanceArea extends Area2D


signal pressed
signal released


@export var main_area: bool = false
@export var texture: Texture = preload("uid://3smmy2u8b5q1") # basic_dance_area.aseprite
@export var flip_h: bool = false
@export var flip_v: bool = false


var inner_areas: Array[Area2D]


@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready() -> void:
	pressed.connect(_on_pressed)
	released.connect(_on_released)
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	sprite_2d.texture = texture
	
	sprite_2d.flip_h = flip_h
	sprite_2d.flip_v = flip_v


func _on_pressed() -> void:
	for note in inner_areas:
		if note is BasicNote:
			note.pressed()


func _on_released() -> void:
	for note in inner_areas:
		if note is BasicNote:
			note.released()


func _on_area_entered(area: Area2D) -> void:
	if area is BasicNote:
		inner_areas.append(area)


func _on_area_exited(area: Area2D) -> void:
	if area is BasicNote:
		inner_areas.erase(area)
