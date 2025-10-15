class_name PhoneScreen extends Control


@onready var _collection_button: TextureButton = %CollectionButton
@onready var _shop_button: TextureButton = %ShopButton
@onready var _profile_page_button: TextureButton = %ProfilePageButton
@onready var _settings_button: TextureButton = %SettingsButton
@onready var _chats_button: TextureButton = %ChatsButton
@onready var _current_screen_scroll: ScrollContainer = %CurrentScreenScroll
@onready var _top_tab: Control = %TopTab


func _ready() -> void:
	_chats_button.pressed.connect(_on_chat_button_pressed)
	_settings_button.pressed.connect(_on_settings_button_pressed)
	_collection_button.pressed.connect(_on_collection_button_pressed)
	_shop_button.pressed.connect(_on_shop_button_pressed)
	_profile_page_button.pressed.connect(_on_profile_page_button)
	
	_on_settings_button_pressed()


func _on_chat_button_pressed() -> void:
	_reset_scroll_container()
	_reset_top_tab()
	
	var chats_screen: ChatsScreen = preload("res://scenes/ui/chats_screen.tscn").instantiate()
	
	chats_screen.chats_resources =[
		preload("res://resources/dostoevsky_chat_resource.tres"),
		preload("res://resources/tetris_stick.tres"),
		preload("res://resources/stolas.tres")
	]
	
	_current_screen_scroll.add_child(chats_screen)
	
	chats_screen.redirect_to_chat.connect(_create_and_redirect_to_chat)


func _on_settings_button_pressed() -> void:
	_reset_scroll_container()
	_reset_top_tab()
	
	var settings_screen: SettingsScreen = preload("res://scenes/ui/settings_screen.tscn").instantiate()
	
	_current_screen_scroll.add_child(settings_screen)


func _reset_scroll_container() -> void:
	for child in _current_screen_scroll.get_children():
		child.queue_free()


func _reset_top_tab() -> void:
	for child in _top_tab.get_children():
		child.queue_free()


func _create_and_redirect_to_chat(chat_res: ChatResource) -> void:
	_reset_scroll_container()
	#_prepare_ane_set_tob_tab_to_chat(chat_res)
	var chat_screen: ChatScreen = preload("res://scenes/ui/chat_screen.tscn").instantiate()
	
	chat_screen.chat_resource = chat_res
	
	_current_screen_scroll.add_child(chat_screen)


func _on_collection_button_pressed() -> void:
	_reset_scroll_container()
	var collsection_screen: Control = preload("uid://cj4npcefflne0").instantiate() #collection_screen.tscn
	
	_current_screen_scroll.add_child(collsection_screen)


func _on_shop_button_pressed() -> void:
	_reset_scroll_container()
	var shop_screen: Control = preload("uid://7w4k2mooum83").instantiate() # shop_screen.tscn
	
	_current_screen_scroll.add_child(shop_screen)


func _on_profile_page_button() -> void:
	_reset_scroll_container()
	var my_profile_screen: Control = preload("uid://cibhf33s337at").instantiate() # my_page_screen.tscn
	
	_current_screen_scroll.add_child(my_profile_screen)


#func _prepare_ane_set_tob_tab_to_chat(chat_res: ChatResource) -> void:
	#_reset_top_tab()
	#var chat_top_tab: ChatTopTab = preload("res://scenes/ui/chat_top_tab.tscn").instantiate()
	#
	#chat_top_tab.chat_res = chat_res
	#_top_tab.add_child(chat_top_tab)
