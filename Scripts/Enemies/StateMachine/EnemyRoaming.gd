##extends EnemyState
##
#func enter():
	#enemy.animation_player.play("Run")
#
#func process(delta):
	#move(delta)
	#
##func move(delta):
	##if !enemy.dead == false:
		##if enemy.is_chase == false:
			##enemy.velocity += enemy.direction * enemy.speed * delta
		##enemy.is_roaming = true
	##elif enemy.dead == true:
		##enemy.velocity.x = 0
