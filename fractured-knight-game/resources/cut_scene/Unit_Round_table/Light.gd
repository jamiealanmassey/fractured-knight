extends Sprite

var s_size = Vector2(0.01, 0.01)
var m_size = Vector2(1,1)
var i_size = Vector2(0.001, 0.001)
var none = Vector2(0,0)
var is_max = false

func _ready():
	visible = false
	scale.x = s_size.x
	scale.y = s_size.y
	pass

func increase():
	visible = true
	if (s_size < m_size):
		s_size += i_size
		scale.x = s_size.x
		scale.y = s_size.y
	elif (s_size >= m_size):
		is_max = true
	pass

func decrease():
	if (s_size > none) and (is_max ==true) :
		s_size -= i_size
		scale.x = s_size.x
		scale.y = s_size.y
	elif (s_size <= none):
		visible = false
	pass
