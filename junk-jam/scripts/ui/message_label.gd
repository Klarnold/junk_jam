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
	visible = true
	print("%s --- %s --- %s --- %s --- %s" % [size.x, get_parent().size.x, text, message_resource.message_owner, size_flags_horizontal])
	if message_resource.message_owner == MessageOwner.ME:
		size_flags_horizontal = Control.SIZE_SHRINK_END
	
	if (size.x + 10) > get_parent().size.x:
		#print("%s --- %s --- %s" % [size.x, get_parent().size.x, text])
		size_flags_horizontal = Control.SIZE_EXPAND_FILL
		autowrap_mode = TextServer.AUTOWRAP_ARBITRARY
	
	visible = false
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	visible = true
