class_name ChoosableMessageLabel extends MessageLabel


signal chosen(message_res: MessageResource)

var index: int = -1

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		chosen.emit(message_resource)


func _ready() -> void:
	#theme.set_stylebox("StyleBoxFlat", "Normal", )
	super()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	add_theme_stylebox_override("normal", preload("uid://cujwvcugwq2y8"))
	modulate.r = 1
	modulate.g = 1
	modulate.b = 1


func _on_mouse_entered() -> void:
	add_theme_stylebox_override("normal", preload("uid://ci6do1mppwhry"))


func _on_mouse_exited() -> void:
	add_theme_stylebox_override("normal", preload("uid://cujwvcugwq2y8"))
