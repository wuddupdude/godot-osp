extends Area2D

onready var is_held = get_parent().is_held

func _on_area_enter(area):
	if is_held == true:
		print(area.get_global_pos())

func _on_area_enter_shape(area_id, area, area_shape, self_shape):
	if is_held == true:
		print(area_id)
		print(area.get_child(area_shape).get_pos())
		print(area_shape)
		print(self_shape)

func _on_part_is_held():
	print("true")

func _ready():
	set_process(true)
	# connect("area_enter", self, "_on_area_enter")
	connect("area_enter_shape", self, "_on_area_enter_shape")

func _process(delta):
	pass
	#print(get_overlapping_bodies())
