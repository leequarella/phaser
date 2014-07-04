class @Gun
  constructor: ->
    @rateOfFire = 2
    @bulletSpeed = 300
    @lastFired = Date.now()

  fire: (originX, originY) ->
    return if (@lastFired > Date.now() - (1000/@rateOfFire)) || gameOver
    @lastFired = Date.now()
    bullet = bullets.create(originX, originY, 'bullet')
    bullet.scale.x = 0.5
    bullet.scale.y = 0.5
    bullets.setAll('checkWorldBounds', true)
    bullets.setAll('outOfBoundsKill', true)
    game.physics.arcade.moveToPointer(bullet, @bulletSpeed)
