extends EnemyState


func enter():
	enemy.is_dead = true
	print("Entrando al dead")
	enemy.velocity.x = 0
	enemy.queue_free()
