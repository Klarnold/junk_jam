class_name ChatResource extends Resource

signal affection_changed(affection_value)

#TODO chat resource
@export var texture: Texture
@export var icon_texture: Texture
@export var name: String
@export var last_active: String = "now"
@export_range(-100.0, 100.0, 0.1) var affection: float = 0.0
@export var messages: Array[MessageResource]
 

func set_affection(new_afffection: float) -> void:
	if affection == new_afffection:
		return
	
	affection = new_afffection
	affection_changed.emit(affection)
