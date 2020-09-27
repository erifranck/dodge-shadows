extends Area2D


export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
export var destroyed = false

signal hit
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	destroyed = false
	hide()
	
func _process(delta):
	if not destroyed: 
		var velocity = Vector2()  # The player's movement vector.
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			position += velocity * delta
			position.x = clamp(position.x, 0, screen_size.x)
			position.y = clamp(position.y, 0, screen_size.y)
			$AnimatedSprite.flip_h = velocity.x < 0
	
func start(pos):
	position = pos
	destroyed = false
	show()
	$AnimatedSprite.animation = 'fly'
	$AnimatedSprite.play()
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
	destroyed = true
	$AnimatedSprite.animation = 'destroy'
	$AnimatedSprite.play();
	$CollisionShape2D.set_deferred("disabled", true)
	yield(get_tree().create_timer(2), "timeout")
	hide()  # Player disappears after being hit.
	emit_signal("hit")

