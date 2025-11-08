class_name SettingsScreen extends Control


@onready var _music_slider: HSlider = %MusicSlider
@onready var _sound_slider: HSlider = %SoundSlider
@onready var _main_menu_button: Button = %MainMenuButton
@onready var _exit_button: Button = %ExitButton
@onready var _music_container: HBoxContainer = %MusicContainer
@onready var _sound_container: HBoxContainer = %SoundContainer
@onready var children: Array[Control] = [
	_music_container, _sound_container, _music_slider,
	_sound_slider, _main_menu_button, _exit_button
]


func _ready() -> void:
	_prepare_sliders()
	
	_music_slider.value_changed.connect(_set_music_db)
	_sound_slider.value_changed.connect(_set_sound_db)
	
	_exit_button.pressed.connect(get_tree().quit)
	
	for child in children:
		var tween: Tween = create_tween()
		tween.tween_property(child, "modulate:a", 1.0, 0.5)
		await get_tree().create_timer(0.1).timeout


func _set_music_db(music_value: float) -> void:
	var music_db: float = linear_to_db(music_value)
	AudioServer.set_bus_volume_db(1, music_db)


func _set_sound_db(sound_value: float) -> void:
	var sound_db: float = linear_to_db(sound_value)
	AudioServer.set_bus_volume_db(2, sound_db)


func _prepare_sliders() -> void:
	var music_value: float = db_to_linear(AudioServer.get_bus_volume_db(1))
	var sfx_value: float = db_to_linear(AudioServer.get_bus_volume_db(2))
	
	_music_slider.value = music_value
	_sound_slider.value = sfx_value
