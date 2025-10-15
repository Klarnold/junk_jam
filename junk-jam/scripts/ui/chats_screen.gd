class_name ChatsScreen extends VBoxContainer


signal redirect_to_chat(chat_resource: ChatResource)


@export var chats_resources: Array[ChatResource]


#@onready var _chats_container: VBoxContainer = %ChatsContainer


func _ready() -> void:
	for chat_resource in chats_resources:
		var chat_container: ChatContainer = preload("res://scenes/ui/chat_container.tscn").instantiate()
		
		chat_container.chat_resource = chat_resource
		chat_container.modulate.a = 0
		add_child(chat_container)
		
		chat_container.call_to_redirect_to_chat.connect(redirect_to_chat.emit)
		
		var chat_container_tween: Tween = create_tween()
		chat_container.global_position.x = 0.0
		chat_container_tween.tween_property(chat_container, "modulate:a", 1.0, 0.8)
		
		var position_tween: Tween = create_tween()
		position_tween.tween_property(chat_container, "global_position:x", -100.0, 0.2)
		position_tween.tween_property(chat_container, "global_position:x", 384.0, 0.5).set_trans(Tween.TRANS_SPRING)
		await get_tree().create_timer(0.2).timeout
		
		
		await get_tree().physics_frame
		await get_tree().physics_frame
		
		#print(chat_container.global_position)
