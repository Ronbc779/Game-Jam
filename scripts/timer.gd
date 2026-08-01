extends Control

signal boarding_time_reached

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

@export var minutes_until_boarding: int = 30

var start_total_minutes: int = 0
var minutes_elapsed: int = 0
var boarding_triggered: bool = false

func _ready() -> void:
	var system_time := Time.get_time_dict_from_system()
	start_total_minutes = system_time["hour"] * 60 + system_time["minute"]

	timer.wait_time = 1.0
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

	update_label()

func _on_timer_timeout() -> void:
	if boarding_triggered:
		return
	minutes_elapsed += 1
	update_label()
	if minutes_elapsed >= minutes_until_boarding:
		boarding_triggered = true
		timer.stop()
		boarding_time_reached.emit()

func update_label() -> void:
	var current_total := start_total_minutes + minutes_elapsed
	label.text = format_time(current_total)

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
