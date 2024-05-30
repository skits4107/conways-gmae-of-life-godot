extends TextEdit


func _ready():
	self.text_changed.connect(text_changed_event)

	
func text_changed_event() -> void:
	if text.is_valid_float():
		GameSettings.camera_speed = text.to_float()
