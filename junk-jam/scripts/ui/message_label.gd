class_name MessageLabel extends RichTextLabel

@export var message_resource: MessageResource

enum MessageOwner{
	ME,
	PERSON
}


func _ready() -> void:
	if not message_resource:
		printerr("%s has no message_resource" % name)
		return
	
	text = message_resource.text
	await  get_tree().process_frame
	await  get_tree().process_frame
	
	print("%s --- %s" % [size.x, get_parent().size.x])
	if message_resource.message_owner == MessageOwner.ME:
		size_flags_horizontal = Control.SIZE_SHRINK_END
	
	if (size.x + 30) > get_parent().size.x:
		size_flags_horizontal = Control.SIZE_EXPAND_FILL
		autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	visible = true
