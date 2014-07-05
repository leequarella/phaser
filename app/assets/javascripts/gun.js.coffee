class @Gun
  constructor: ->
    @rateOfFire = 2
    @bulletSpeed = 300
    @lastFired = Date.now()

  fire: (originX, originY) ->
    return if (@lastFired > Date.now() - (1000/@rateOfFire)) || gameOver
    @lastFired = Date.now()
    bullet = bullets.create(originX, originY, 'bullet')
    game.physics.p2.enable bullet
    bullet.scale.set 0.5
    bullets.setAll('checkWorldBounds', true)
    bullets.setAll('outOfBoundsKill', true)
    bullet.body.setCollisionGroup(bulletsCollisionGroup)
    bullet.body.collides([baddiesCollisionGroup])
    setTimeout (=> bullet.kill()), 3000
    game.physics.arcade.moveToPointer(bullet, @bulletSpeed)
