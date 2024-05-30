extends TextEdit


func _ready():
	self.text_changed.connect(text_changed_event)

	
func text_changed_event() -> void:
	if text.is_valid_float():
		var val : float = text.to_float()
		if val >= 0.0 or val <= 1.0:
			GameSettings.grid_color.g = val
