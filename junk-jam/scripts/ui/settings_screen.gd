class_name SettingsScreen extends Control


@onready var _music_slider: HSlider = %MusicSlider
@onready var _sound_slider: HSlider = %SoundSlider
@onready var _main_menu_button: Button = %MainMenuButton
@onready var _exit_button: Button = %ExitButton


func _ready() -> void:
	_music_slider.value_changed.connect(_set_music_db)
	_sound_slider.value_changed.connect(_set_sound_db)
	
	_exit_button.pressed.connect(queue_free)


func _set_music_db(music_value: float) -> void:
	var music_db: float = linear_to_db(music_value)
	AudioServer.set_bus_volume_db(1, music_db)


func _set_sound_db(sound_value: float) -> void:
	var sound_db: float = linear_to_db(sound_value)
	AudioServer.set_bus_volume_db(2, sound_db)
