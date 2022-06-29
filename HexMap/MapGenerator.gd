extends Spatial

export(Vector2) var grid_size = Vector2(8, 8)
export(Resource) var hex_tile
export(Resource) var coin
export(Resource) var enemy

export(Array, Resource) var hex_data

onready var map = get_node("Map")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.total_coins = 0
	PlayerData.coins_value_change(-PlayerData.coins_get())
	PlayerData.health = PlayerData.max_health
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	call_deferred("layout_grid")
	#layout_grid()

func _start_game():
	print("Finished")
	#get_tree().paused = false

func layout_grid():
	yield(generate_simplex(), "completed")
	call_deferred("_start_game")

var rng = RandomNumberGenerator.new()
func generate_simplex():
	rng.randomize()
	var simplexNoise = OpenSimplexNoise.new()
	simplexNoise.seed = rng.randi()
	simplexNoise.octaves = 3
	simplexNoise.period = 20.0
	simplexNoise.persistence = 1
	simplexNoise.lacunarity = 2
	
	for x in grid_size.x:
		for y in grid_size.y:
			var noise = simplexNoise.get_noise_2d(x, y)
			var tile: Spatial = hex_tile.instance()
			map.add_child(tile)
			tile.transform.origin = spawn_hex(Vector2(x, y))
			tile.setup_tile(hex_data[get_tile_type(noise, tile)])

		yield(get_tree().create_timer(.003), "timeout")
	
	PlayerData.emit_signal("coins_changed", 0)
	#yield(get_tree().create_timer(.01), "timeout")
	#_start_game()
	

func get_tile_type(var noise, var tile):
	
	if noise < -.5:
		return 0
	elif noise < 0:
		var random_number = rng.randi_range(0, 100) 
		if random_number <= 1:
			return 3
		elif random_number <= 5:
			if rng.randf_range(0, 1) < .25:
				spawn_coin(tile, 8.5)
			return 4
		else:
			if rng.randf_range(0, 1) < .01:
				spawn_coin(tile, 1.5)
			return 1
	else:
		if rng.randf_range(0, 1) < .03:
			spawn_enemy(tile)
		return 2
		

func spawn_coin(tile, y_pos):
	var instance = coin.instance()
	map.add_child(instance)
	instance.global_transform.origin = tile.global_transform.origin
	instance.global_transform.origin.y += y_pos
	PlayerData.emit_signal("increase_total_coins", 1)

func spawn_enemy(tile):
	var instance = enemy.instance()
	map.add_child(instance)
	instance.global_transform.origin = tile.global_transform.origin
	instance.global_transform.origin.y += 8.5
	rng.randomize()
	instance.rotation_degrees = Vector3(0, rng.randi_range(0, 359), 0)

func spawn_hex(var coordinate: Vector2):
	var column: int = coordinate.x
	var row: int = coordinate.y
	
	var width: float
	var height: float
	var xPosition: float
	var yPosition: float
	var shouldOffset: bool
	var horizontalDistance: float
	var verticalDistance: float
	var offset: float
	var size: float = 1.616
	
	shouldOffset = (row % 2) == 0;
	width = sqrt(3) * size
	height = 2.0 * size
	
	horizontalDistance = width
	verticalDistance = height * (3.0/4.0)
	
	if shouldOffset == true:
		offset = width / 2.0
	else:
		offset = 0
	
	xPosition = (column * (horizontalDistance)) + offset
	yPosition = (row * verticalDistance)
	
	return Vector3(xPosition, 0, -yPosition)
