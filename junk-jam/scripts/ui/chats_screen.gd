class_name ChatsScreen extends VBoxContainer


signal redirect_to_chat(chat_resource: ChatResource)


@export var chats_resources: Array[ChatResource]


#@onready var _chats_container: VBoxContainer = %ChatsContainer


func _ready() -> void:
	for chat_resource in chats_resources:
		var chat_container: ChatContainer = preload("res://scenes/ui/chat_container.tscn").instantiate()
		
		chat_container.chat_resource = chat_resource
		add_child(chat_container)
		
		chat_container.call_to_redirect_to_chat.connect(redirect_to_chat.emit)
