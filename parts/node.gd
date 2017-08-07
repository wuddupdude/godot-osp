extends CollisionShape2D

# The radius of a node.
var radius = 5 # px

# Draw the node.
func _draw():
	draw_circle(Vector2(0,0), radius, Color(0, 1, 0))

func _ready():
	set_z(-1)
	set_trigger(true)
	get_shape().set_radius(radius)
