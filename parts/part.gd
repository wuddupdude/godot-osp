extends RigidBody2D

# Is the mouse pointer touching the part?
var is_touched = false

# Is the part being held?
var is_held = false

# Save the node positions.
func save():
	var savedict = {
		filename=get_filename(),
		parent=get_parent().get_path(),
		posx=get_pos().x,
		posy=get_pos().y
	}
	return savedict

# Callback when mouse pointer enters the part.
func _on_mouse_enter():
	is_touched = true

# Callback when mouse pointer exits the part.
func _on_mouse_exit():
	is_touched = false

func _ready():
	set_mode(MODE_STATIC)
	set_pickable(true)
	connect("mouse_enter", self, "_on_mouse_enter")
	connect("mouse_exit", self, "_on_mouse_exit")
	set_process_unhandled_input(true)

# Pickup the part on click and drop it on the subsequent click.
# A node's snap action overrides this behavior.
func _unhandled_input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if is_touched == true and is_held == false:
			set_layer_mask(2)
			is_held = true
		else:
			set_layer_mask(1)
			is_held = false
	if is_held == true:
		set_pos(get_global_mouse_pos())
