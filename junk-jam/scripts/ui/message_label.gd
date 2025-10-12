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
	if message_resource.show:
		appear()
	else:
		modulate.a = 0.0
	
	if get_theme_stylebox("normal") != preload("uid://cujwvcugwq2y8"):
		if message_resource.affection_change < 0.0:
			modulate.r = 0.6
			modulate.g = 0
			modulate.b = 0
		elif message_resource.affection_change > 0.0:
			modulate.r = 0.0
			modulate.g = 0.6
			modulate.b = 0.0


func appear() -> void:
	var tween: Tween = create_tween()
	
	tween.tween_property(self, "modulate:a", 1.0, 0.2)


func destroy() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var tween: Tween = create_tween()
	
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.finished.connect(queue_free)
