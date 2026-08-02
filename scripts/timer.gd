extends Control

signal boarding_time_reached
signal PM_check(pm_check: bool)

@onready var label: Label = $Label
@onready var boarding_label: Label = $BoardingLabel
@onready var timer: Timer = $Timer

@export var minutes_until_boarding: int = 30
@export var flash_threshold_seconds: int = 10

var start_total_minutes: int = 0
var minutes_elapsed: int = 0
var boarding_triggered: bool = false
var flash_on: bool = false

func _ready() -> void:
	var system_time := Time.get_time_dict_from_system()
	start_total_minutes = system_time["hour"] * 60 + system_time["minute"]
	var pm_check: bool = true if system_time["hour"]>17 else false
	PM_check.emit(pm_check)
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

	boarding_label.text = "Boarding: %s" % format_time(start_total_minutes + minutes_until_boarding)
	update_label()

func _on_timer_timeout() -> void:
	if boarding_triggered:
		return

	minutes_elapsed += 1
	update_label()
	_update_flash()

	if minutes_elapsed >= minutes_until_boarding:
		boarding_triggered = true
		timer.stop()
		boarding_time_reached.emit()
		GameResult.lose("You missed your flight. Now you have to wait next year.")

func update_label() -> void:
	var current_total := start_total_minutes + minutes_elapsed
	label.text = format_time(current_total)

func _update_flash() -> void:
	var seconds_left := minutes_until_boarding - minutes_elapsed
	if seconds_left <= flash_threshold_seconds and seconds_left > 0:
		flash_on = not flash_on
		label.modulate = Color.RED if flash_on else Color.WHITE
	else:
		label.modulate = Color.WHITE

func format_time(total_minutes: int) -> String:
	total_minutes = total_minutes % (24 * 60)
	var hour_24 := total_minutes / 60
	var minute := total_minutes % 60
	var is_pm := hour_24 >= 12
	var hour_12 := hour_24 % 12
	if hour_12 == 0:
		hour_12 = 12
	var suffix := "PM" if is_pm else "AM"
	return "%02d:%02d %s" % [hour_12, minute, suffix]
