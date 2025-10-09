class_name ChatScreen extends PanelContainer


signal destroy_chosen


@export var chat_resource: ChatResource

@onready var _person_messages: VBoxContainer = %PersonMessages
@onready var _my_messages: VBoxContainer = %MyMessages


var show_id: int = 0


func _ready() -> void:
	_check_messages()


func prepare_and_create_message_label(message_resource: MessageResource) -> void:
	var message_label: MessageLabel = preload("res://scenes/ui/message_label.tscn").instantiate()
	message_label.message_resource = message_resource
	
	if message_resource.message_owner == MessageLabel.MessageOwner.ME:
		_my_messages.add_child(message_label)
		var additional_label = message_label.duplicate()
		additional_label.modulate.a = 0
		_person_messages.add_child(additional_label)
	else:
		_person_messages.add_child(message_label)
		var additional_label = message_label.duplicate()
		additional_label.modulate.a = 0
		_my_messages.add_child(additional_label)


func prepare_and_create_choosable_message_labels(choosable_message_resources: ChoosableMessageResource) -> void:
	var choosable_message_label_scene: PackedScene = preload("res://scenes/ui/message_label.tscn")
	
	# i need to connect to signal chosen on every message_label and set text in choosable_resources
	for choosable_message_resource in choosable_message_resources.choosable_messages.keys():
		var choosable_message_label = choosable_message_label_scene.instantiate()
		
		choosable_message_label.set_script(preload("res://scripts/ui/choosable_message_label.gd"))
		choosable_message_label = choosable_message_label as ChoosableMessageLabel
		
		choosable_message_label.message_resource = choosable_message_resource
		destroy_chosen.connect(choosable_message_label.queue_free) # importnt for destroying choosable_labels upon chosing 
		
		choosable_message_label.chosen.connect(_on_chosen_message_label.bind(choosable_message_resources))
		
		if choosable_message_resource.message_owner == MessageLabel.MessageOwner.ME:
			_my_messages.add_child(choosable_message_label)
			var additional_label = choosable_message_label.duplicate()
			destroy_chosen.connect(additional_label.queue_free)
			additional_label.modulate.a = 0
			_person_messages.add_child(additional_label)
		else:
			_person_messages.add_child(choosable_message_label)
			var additional_label = choosable_message_label.duplicate()
			destroy_chosen.connect(additional_label.queue_free)
			additional_label.modulate.a = 0
			_my_messages.add_child(additional_label)


func _on_chosen_message_label(chosen_message_res: MessageResource, choosable_message_resources: ChoosableMessageResource):
	choosable_message_resources.text = chosen_message_res.text
	choosable_message_resources.chosen_res = chosen_message_res
	
	destroy_chosen.emit()
	
	for message_resource in choosable_message_resources.choosable_messages[chosen_message_res]:
		chat_resource.messages.append(message_resource)
	_check_messages()


func _check_messages() -> void:
	for message_res_id in range(show_id, chat_resource.messages.size()):
		if not chat_resource.messages[message_res_id].show:
			show_id = message_res_id
			return
		
		if chat_resource.messages[message_res_id] is ChoosableMessageResource:
			if (chat_resource.messages[message_res_id] as ChoosableMessageResource).chosen_res == null:
				prepare_and_create_choosable_message_labels(chat_resource.messages[message_res_id])
				show_id = message_res_id
				break
			else:
				prepare_and_create_message_label(chat_resource.messages[message_res_id])
		else:
			prepare_and_create_message_label(chat_resource.messages[message_res_id])
