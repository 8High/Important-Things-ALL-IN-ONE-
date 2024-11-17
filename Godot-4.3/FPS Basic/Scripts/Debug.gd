extends PanelContainer

@onready var property_container = %VBoxContainer

func _process(delta):
	add_property("FPS", "%.2f" %(1.0/delta), 0)

func _ready() -> void:
	Global.debug = self
	visible = false

func _input(event):
	if event.is_action_pressed("Debug"):
		visible = !visible

func add_property(title: String, value, order): 
	var target
	target = property_container.find_child(title, true, false) 
	if !target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible: 
		target.text = title + ": " + str(value)
		property_container.move_child(target,order)
