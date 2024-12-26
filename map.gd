extends TileMapLayer


var fnl := FastNoiseLite.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 8:
		print()
	#randomize()
	fnl.set_seed(109)
	fnl.frequency = 0.0001
	generate_map()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_map() -> void:
	var max_value = -1
	var min_value = 1
	for x in 200:
		for y in 200:
			var value = fnl.get_noise_2d(x*100, y*100)
			max_value = max(max_value, value)
			min_value = min(min_value, value)
			set_cell(Vector2i(x, y), 0, a(roundi((value + 0.7) * 5)))
	print(max_value, " - ", min_value)

func a(value) -> Vector2i:
	return Vector2i(value % 4, int(value / 4))
