extends ParallaxBackground

const cloudSpeed = 0.5
const mount1Speed = 1.3
const mount2Speed = 0.8

func _process(delta):
	$Clouds.motion_offset.x -= cloudSpeed
	$Mount1.motion_offset.x -= mount1Speed
	$Mount2.motion_offset.x -= mount2Speed
