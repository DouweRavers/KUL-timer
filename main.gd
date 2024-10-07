extends Control

var time := 0
var configured_time := 0

func _on_timer_timeout() -> void:
	time -= 1
	if time <= 0:
		$BeepAudio.play()
		if $CenterContainer/VBoxContainer/HBoxContainer2/RepeatCheckbox.button_pressed: 
			time = configured_time
		else:
			$Timer.stop()
	set_time_display()

func _on_start_button_pressed() -> void:
	time = configured_time
	_on_continue_pressed()

func _on_continue_pressed() -> void:
	$Timer.start()
	$CenterContainer/VBoxContainer/HBoxContainer2/StartButton.visible = false
	$CenterContainer/VBoxContainer/HBoxContainer2/ContinueButton.visible = false
	$CenterContainer/VBoxContainer/HBoxContainer2/StopButton.visible = true
	set_time_display()

func _on_stop_button_pressed() -> void:
	$Timer.stop()
	$CenterContainer/VBoxContainer/HBoxContainer2/StartButton.visible = true
	$CenterContainer/VBoxContainer/HBoxContainer2/ContinueButton.visible = time > 0
	$CenterContainer/VBoxContainer/HBoxContainer2/StopButton.visible = false
	set_time_display()

func _on_configure_time_change(_value:float)->void:
	configured_time = 0
	configured_time += $CenterContainer/VBoxContainer/HBoxContainer/SecondSpinBox.value
	configured_time += $CenterContainer/VBoxContainer/HBoxContainer/MinuteSpinBox.value * 60
	configured_time += $CenterContainer/VBoxContainer/HBoxContainer/HourSpinBox.value * 3600
	if $Timer.is_stopped():
		time = configured_time
		set_time_display()

func set_time_display():
	var hour := time / 3600
	var minute := time %3600 / 60
	var second := time % 3600 % 60
	$CenterContainer/VBoxContainer/TimeDisplay.text = "%02d:%02d:%02d" % [hour, minute, second]
	
