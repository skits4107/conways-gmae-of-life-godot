extends Node2D


var tile_size : int = 64
var color : Color = Color(1.0, 0.74, 0.0)
@onready var width : int = get_parent().width
@onready var height : int = get_parent().height
var line_width : float = 3.0

@export var camera : Camera2D = null

func _ready():
	set_process(true)



func _draw():
	#draw all of the horizontal lines
	for y in range(-height, height):
		#draw line from left to right for current y
		draw_line(Vector2((-width) * tile_size, y * tile_size), Vector2(width * tile_size, y * tile_size), color, line_width)
	
	#draw all of the vertical lines
	for x in range(-width, width):
		#draw line from top to bottom for current x
		draw_line(Vector2(x * tile_size, (-height) * tile_size), Vector2(x * tile_size, height * tile_size), color, line_width)
				

func _process(delta):
	if camera != null:
		#by adjsting the line size to be inversely proportional to the zoom i ensure  the lines always display properly
		line_width = 1.2 / camera.zoom.x
		
	queue_redraw()


