class_name ChatContainer extends PanelContainer


signal call_to_redirect_to_chat(chat_res: ChatResource)


@export var chat_resource: ChatResource


@onready var _texture_rect: TextureRect = %TextureRect
@onready var _last_seen_label: RichTextLabel = %LastSeenLabel
@onready var _last_meassage: RichTextLabel = %LastMeassage
@onready var _name_label: RichTextLabel = %NameLabel


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		call_to_redirect_to_chat.emit(chat_resource)


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	_texture_rect.texture = chat_resource.icon_texture
	_name_label.text = chat_resource.name
	
	_last_meassage.text = chat_resource.messages[-1].text


func _on_mouse_entered() -> void:
	add_theme_stylebox_override("panel", preload("uid://cqg50s0gl2xsi"))

func _on_mouse_exited() -> void:
	add_theme_stylebox_override("panel", preload("uid://cuhhe1ix0eiio"))
