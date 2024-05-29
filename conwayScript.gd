extends TileMap


var timer : Timer = Timer.new()
var width : int = 20
var height : int = 10

var is_running : bool = false

const CONWAY_TILESET_ID : int = 2

const LIVING_CELL : Vector2i = Vector2i(1,0)

const DEAD_CELL : Vector2i = Vector2i(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():

	create_random_grid()
	
	add_child(timer)
	timer.wait_time = 0.2  # Update interval
	timer.one_shot = false
	timer.timeout.connect(update_grid)
	timer.start()
	
func create_random_grid() -> void:
	for x in range(-width, width):
		for y in range(-height, height):
			var choice : int = randi() % 2
			var state : Vector2i = DEAD_CELL
			if choice == 1:
				state = LIVING_CELL
			set_cell(0, Vector2i(x, y), CONWAY_TILESET_ID, state)

func create_blank_grid() -> void:
	for x in range(-width, width):
		for y in range(-height, height):
			set_cell(0, Vector2i(x, y), CONWAY_TILESET_ID, DEAD_CELL)


# Called everytime the tiemr runs out
func update_grid() -> void:
	#exit early if it is not running
	if not is_running:
		return
		
	var new_state_map : Dictionary = {}
	for x in range(-width, width):
		for y in range(-height, height):
			var current_tile_state : Vector2i = get_cell_atlas_coords(0, Vector2i(x,y))
			var new_tile_state : Vector2i = current_tile_state
			var count : int = count_alive_neighbors(Vector2i(x,y))
	
			#rules for updating state
			if current_tile_state == LIVING_CELL and (count < 2 or count > 3):
				new_tile_state = DEAD_CELL
			elif current_tile_state == DEAD_CELL and count == 3:
				new_tile_state = LIVING_CELL
				
			#only need to update if the state is different
			if new_tile_state != current_tile_state: 
				new_state_map[Vector2i(x,y)] = new_tile_state
				
	#update tiles			
	for pos in new_state_map.keys():
		set_cell(0, pos, CONWAY_TILESET_ID, new_state_map[pos])


func count_alive_neighbors(coords : Vector2i) -> int:
	var count : int = 0
	for x in range(coords.x-1, coords.x+2):
		for y in range(coords.y-1, coords.y+2):
			if x == coords.x and y==coords.y:
				continue #skip current cell
			var cell_state : Vector2i = get_cell_atlas_coords(0, Vector2i(x,y))
			if cell_state == LIVING_CELL:
				count += 1
	return count

func _input(event):
	if event is InputEventMouseButton:
		#left bitton was pressed
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#get the position of the tile clicked on
			var tile_pos : Vector2i = local_to_map(get_local_mouse_position())
			# get the current state of the tile
			var current_tile_state : Vector2i = get_cell_atlas_coords(0, tile_pos)
			#flip tile state
			var new_state : Vector2i = LIVING_CELL if current_tile_state == DEAD_CELL else DEAD_CELL 
			#set tile state
			set_cell(0, tile_pos, CONWAY_TILESET_ID, new_state)
			
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			is_running = not is_running
		if event.keycode == KEY_Z:
			create_blank_grid()
			





