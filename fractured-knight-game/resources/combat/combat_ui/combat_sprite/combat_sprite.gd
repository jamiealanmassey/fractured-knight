extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func combat_started():
	self.show()
	self.play("idle")

# When this sprite attacks, run this
func on_attack_hit(damage):
	self.play("attack")
	# play attack animation
	pass
	
# when this sprite gets hit, run this
func on_received_hit(damage):
	if damage == 0:
		# play hit for no damage
		pass
	else:
		# play hit for some damage
		self.play("hurt")
		$Timer.start()
		var i = 0
		$Label.text = str(damage)
		print($Label.text)
		while i < 20:
			
			$Label.rect_position.y -= 40
			yield($Timer, "timeout")
			i += 1
		
		$Label.text = ""
		$Label.rect_position.y += 20 * 40
	pass

#when this sprite attacks and misses, run this
func on_attack_miss():
	self.play("attack")
	# play attack animation
	pass


func _on_combat_sprite_animation_finished():
	if self.animation == "dying":
		pass
	elif self.animation != "idle": 
		self.play("idle")
	pass # replace with function body
	
func on_death():
	self.play("dying")
	pass
