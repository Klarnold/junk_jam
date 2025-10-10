class_name ChatTopTab extends Control


@export var chat_res: ChatResource


@onready var _texture_rect: TextureRect = $HBoxContainer/TextureRect
@onready var _name_label: RichTextLabel = $HBoxContainer/VBoxContainer/NameLabel
@onready var _last_active_label: RichTextLabel = $HBoxContainer/VBoxContainer/LastActiveLabel


func _ready() -> void:
	_texture_rect.texture = chat_res.texture # TODO change this to icon_texture
	_name_label.text =  "%s: %s" % [chat_res.name, chat_res.affection]
	_last_active_label.text = chat_res.last_active
	
	chat_res.affection_changed.connect(_on_affection_changed)


func _on_affection_changed(affection_value: float) -> void:
	_name_label.text = "%s: %s" % [chat_res.name, affection_value] 
	pass # TODO finish affection changes
