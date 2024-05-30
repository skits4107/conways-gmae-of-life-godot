extends Button

@export var MenuToToggle : Node2D = null

@onready var currentMenu : Node2D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	if MenuToToggle != null:
		MenuToToggle.visible = true
		currentMenu.visible = false
