extends Area2D

# Callback whenever nodes contact.
func _on_area_enter_shape(area_id, area, area_shape, self_shape):
	# We are only concerned about the part being held.
	if get_parent().is_held == true:
		# The position of the static part's node.
		var to = area.get_child(area_shape).get_global_pos()
		# the position of the held part's node.
		var from = get_child(self_shape).get_global_pos()
		# The vector distance the part has to travel to snap.
		var snap_vector = to - from
		# Snap the part.
		get_parent().translate(snap_vector)
		# Turn off mouse holding.
		get_parent().is_held = false

func _ready():
	connect("area_enter_shape", self, "_on_area_enter_shape")
