class_name ChatResource extends Resource

signal affection_changed(affection_value)

#TODO chat resource
@export var texture: Texture
@export var icon_texture: Texture
@export var emotions: Dictionary[Globals.EmotionType, Texture]
@export var background_textures: Dictionary[Globals.EmotionType, Texture]
@export var name: String
@export var last_active: String = "now"
@export_range(-100.0, 100.0, 0.1) var affection: float = 0.0:
	set = set_affection
@export var messages: Array[MessageResource]
@export var uncompleted_dance_scenes: Array[PackedScene]
@export var completed_dance_scenes: Array[PackedScene]


func set_affection(new_afffection: float) -> void:
	if affection == new_afffection:
		return
	
	affection = clampf(new_afffection, -100.0, 100.0) 
	affection_changed.emit(affection)
