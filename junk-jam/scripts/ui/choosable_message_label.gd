class_name ChoosableMessageLabel extends MessageLabel


signal chosen(message_res: MessageResource)

var index: int = -1

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		chosen.emit(message_resource)


func _ready() -> void:
	super()
