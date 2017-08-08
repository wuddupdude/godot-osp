extends Area2D

# Calculate the right-most x coordinate of the part.
# There has to be a way not to use this, but it sort of works for now.
# Only useful for attaching wings.
func get_rightmost_x_coord(body, body_shape):
	var points = body.get_shape(body_shape).get_points()
	var x = points[0].x
	for point in points:
		if point.x > x:
			x = point.x
	return(x)

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

# Callback whenever a node contacts a part's body.
# Duplicates part and attaches it to both side of the other part.
# Only useful for attaching wings.
# Provides some really shitty VAB behavior.
# Need to think of better ideas.
func _on_body_enter_shape(body_id, body, body_shape, area_shape):
	# We are only concerned about the part being held.
	if get_parent().is_held == true:
		# The position of the static part body's outer wall.
		var to = body.get_pos().x + get_rightmost_x_coord(body, body_shape)
		# var to = body.get_pos().x + 8
		# the position of the held part's node.
		var from = get_child(area_shape).get_global_pos()
		# The vector distance the part has to travel to snap.
		var snap_vector = Vector2(to, from.y) - from
		# Snap the part.
		get_parent().translate(snap_vector)
		#
		# Duplicate the part.
		# Really awful block of code below.
		#
		var root_node = get_node("../../../Node")
		var duplicate = load("res://parts/x-wing/X-Wing.tscn").instance()
		root_node.add_child(duplicate)
		duplicate.set_scale(Vector2(-1, 1))
		duplicate.set_pos(get_global_pos())
		duplicate.translate(Vector2(-22, 0))
		duplicate.translate(Vector2(-2 * get_rightmost_x_coord(body, body_shape), 0))
		#
		#
		# Turn off mouse holding
		get_parent().is_held = false
		# print(get_rightmost_x_coord(body, body_shape))
		# print(body.get_shape(body_shape).get_points())

func _ready():
	connect("area_enter_shape", self, "_on_area_enter_shape")
	connect("body_enter_shape", self, "_on_body_enter_shape")
