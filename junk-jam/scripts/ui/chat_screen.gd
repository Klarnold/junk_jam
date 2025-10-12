class_name ChatScreen extends PanelContainer


signal destroy_chosen


@export var chat_resource: ChatResource
#@export var character_resorce: CharacterRes

@onready var _person_messages: VBoxContainer = %PersonMessages
@onready var _my_messages: VBoxContainer = %MyMessages
@onready var _affection_label: RichTextLabel = %AffectionLabel
@onready var _affection_progress_bar: TextureProgressBar = %AffectionProgressBar
@onready var _person_texture: TextureRect = %PersonTexture
@onready var _dance_button: DanceButton = %DanceButton


var show_id: int = 0
var show_dance_button_tween: Tween
var hide_dance_button_tween: Tween
var affection_animation_tween: Tween

func _ready() -> void:
	chat_resource.affection_changed.connect(_on_affection_changed)
	
	_affection_progress_bar.value = chat_resource.affection
	_affection_label.text = "Привязанность: %s" % chat_resource.affection
	_person_texture.texture = chat_resource.texture
	
	_dance_button.chat_res = chat_resource
	
	_check_messages()


func prepare_and_create_message_label(message_resource: MessageResource) -> void:
	var message_label: MessageLabel = preload("res://scenes/ui/message_label.tscn").instantiate()
	message_label.message_resource = message_resource
	
	chat_resource.affection += message_resource.affection_change # needs to be to concretesize affection of character
																# and make choices to have influence
	
	if message_resource.message_owner == MessageLabel.MessageOwner.ME:
		_my_messages.add_child(message_label)
		var additional_label = message_label.duplicate()
		additional_label.modulate.a = 0
		additional_label.message_resource = message_resource.duplicate()
		additional_label.message_resource.show = false
		_person_messages.add_child(additional_label)
	else:
		_person_messages.add_child(message_label)
		var additional_label = message_label.duplicate()
		additional_label.modulate.a = 0
		additional_label.message_resource = message_resource.duplicate()
		additional_label.message_resource.show = false
		_my_messages.add_child(additional_label)
	
	if message_resource.show_dance_button and not message_resource.hide_dance_button:
		_show_dance_button()
		_dance_button.dance_scene_uid = message_resource.dance_scene_uid
		
		_dance_button.pressed.connect(func() -> void:
										message_resource.set_deferred("hide_dance_button", true)
										chat_resource.messages[show_id].show = true) 
	
	if message_resource.hide_dance_button:
		_hide_dance_button()
	#if TODO check for affection????


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
			additional_label.message_resource = choosable_message_resource.duplicate()
			additional_label.message_resource.show = false
			_person_messages.add_child(additional_label)
		else:
			_person_messages.add_child(choosable_message_label)
			var additional_label = choosable_message_label.duplicate()
			destroy_chosen.connect(additional_label.queue_free)
			additional_label.modulate.a = 0
			additional_label.message_resource = choosable_message_resource.duplicate()
			additional_label.message_resource.show = false
			_my_messages.add_child(additional_label)


func _on_chosen_message_label(chosen_message_res: MessageResource, choosable_message_resources: ChoosableMessageResource):
	choosable_message_resources.text = chosen_message_res.text
	choosable_message_resources.chosen_res = chosen_message_res
	
	destroy_chosen.emit()
	
	#for message_resource in choosable_message_resources.choosable_messages[chosen_message_res]: # old version of adding messages to the screen
		#print(message_resource)
		#chat_resource.messages.append(message_resource)
	for message_res_id in choosable_message_resources.choosable_messages[chosen_message_res].size(): # rework of adding messages to hte screen
		chat_resource.messages.insert(show_id + 1 + message_res_id, choosable_message_resources.choosable_messages[chosen_message_res][message_res_id])
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
		
		await get_tree().create_timer(0.05).timeout


func _change_affection_value(additional_value: float) -> void:
	_affection_progress_bar.value += additional_value


func _show_dance_button() -> void:
	if show_dance_button_tween:
		show_dance_button_tween.kill()
	if hide_dance_button_tween:
		hide_dance_button_tween.kill()
	
	_dance_button.disabled = false
	show_dance_button_tween = get_tree().create_tween()
	show_dance_button_tween.tween_property(_dance_button, "modulate:a", 1.0, 2.0)


func _hide_dance_button() -> void:
	if show_dance_button_tween:
		show_dance_button_tween.kill()
	if hide_dance_button_tween:
		hide_dance_button_tween.kill()
	
	_dance_button.disabled = true
	show_dance_button_tween = get_tree().create_tween()
	show_dance_button_tween.tween_property(_dance_button, "modulate:a", 0.0, 2.0)


func _on_affection_changed(new_affection_value: float) -> void:
	if affection_animation_tween:
		affection_animation_tween.kill()
	
	affection_animation_tween = create_tween().set_parallel()
	
	affection_animation_tween.tween_property(_affection_progress_bar, "value", new_affection_value, abs(_affection_progress_bar.value - new_affection_value) * 0.08)
	affection_animation_tween.tween_method(_affection_animation, 0.0, 1.0, abs(_affection_progress_bar.value - new_affection_value) * 0.08)
	
	#_affection_progress_bar.value = new_affection_value
	#_affection_label.text = "Привязанность: %s" % new_affection_value


func _affection_animation(_delta: float) -> void:
	_affection_label.text = "Привязанность: %s" % _affection_progress_bar.value
