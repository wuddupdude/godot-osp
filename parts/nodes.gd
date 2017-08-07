extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	print(get_layer_mask())

func _fixed_process(delta):
	#print(get_overlapping_bodies())
	pass