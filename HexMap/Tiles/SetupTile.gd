extends Spatial

#onready var spawn_point = get_node("Area/Hex/SpawnPoint")

func setup_tile(var hex_data):
	get_node("Area/Hex").set_surface_material (0, hex_data.material)
	scale.y = hex_data.height
