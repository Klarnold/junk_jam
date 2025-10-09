class_name ChoosableMessageResource extends MessageResource

# first one is for messeage_label on screen, second one: for the next message_labels
@export var choosable_messages: Dictionary[MessageResource, Array]
@export var chosen_res: MessageResource
