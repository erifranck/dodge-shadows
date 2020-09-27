extends RigidBody2D

export var min_speed = 150
export var max_speed = 250 


func _ready():
	$AnimatedSprite.animation = 'appear'
	$AnimatedSprite.play()
	$changeAnimation.start()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_changeAnimation_timeout():
	$AnimatedSprite.animation = 'attack'
	$AnimatedSprite.play()
