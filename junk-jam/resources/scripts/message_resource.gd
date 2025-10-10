class_name MessageResource extends Resource



@export var message_owner: MessageLabel.MessageOwner
@export var show: bool = false
@export_multiline var text: String
@export_range(-100.0, 100.0, 0.1) var affection_change: float = 0.0 
#@export var dance_button_res: 
