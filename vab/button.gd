extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Note: This can be called from anywhere inside the tree.  This function is path independent.
func load_game():
	print("lod")
	var savegame = File.new()
	if !savegame.file_exists("user://savegamed.save"):
		return #Error!  We don't have a save to load

    # We need to revert the game state so we're not cloning objects during loading.  This will vary wildly depending on the needs of a project, so take care with this step.
    # For our example, we will accomplish this by deleting savable objects.
	var savenodes = get_tree().get_nodes_in_group("rocket_group")
	for i in savenodes:
		i.queue_free()

    # Load the file line by line and process that dictionary to restore the object it represents
	var currentline = {} # dict.parse_json() requires a declared dict.
	savegame.open("user://savegame.save", File.READ)
	while (!savegame.eof_reached()):
        currentline.parse_json(savegame.get_line())
        # First we need to create the object and add it to the tree and set its position.
        var newobject = load(currentline["filename"]).instance()
        get_node(currentline["parent"]).add_child(newobject)
        newobject.set_pos(Vector2(currentline["posx"],currentline["posy"]))
        # Now we set the remaining variables.
        for i in currentline.keys():
            if (i == "filename" or i == "parent" or i == "posx" or i == "posy"):
                continue
            newobject.set(i, currentline[i])
	savegame.close()

func _button_pressed():
    get_tree().change_scene("res:///rocket/rocket.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if self.is_pressed():
		load_game()
		_button_pressed()
		