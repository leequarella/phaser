Phaser.accelerateToObject = (obj1, obj2, speed) ->
  speed = 60 if typeof speed == 'undefined'
  angle = Math.atan2(obj2.y - obj1.y, obj2.x - obj1.x)
  obj1.body.rotation = angle + game.math.degToRad(90)
  obj1.body.force.x = Math.cos(angle) * speed
  obj1.body.force.y = Math.sin(angle) * speed

Phaser.distanceBetween = (object1, object2) ->
  xs = 0
  ys = 0
  xs = object2.body.x - object1.body.x
  xs = xs * xs
  ys = object2.body.y - object1.body.y
  ys = ys * ys
  Math.sqrt( xs + ys )
