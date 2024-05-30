extends TextEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text_changed.connect(text_changed_event)


	
func text_changed_event() -> void:
	if text.is_valid_float():
		GameSettings.width = text.to_float()
	

