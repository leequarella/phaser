class @Player
  constructor: ->
    @rateOfFire = 2
    @lastFired = Date.now()

  createSprite: ->
    @sprite = game.add.sprite(200,200, 'player')
    game.physics.arcade.enable(@sprite)
    @sprite.body.collideWorldBounds = true
    @sprite.anchor.set(0.5)

  fire: ->
    return if (@lastFired > Date.now() - (1000/@rateOfFire)) || gameOver
    @lastFired = Date.now()
    bullet = bullets.create(@sprite.body.x, @sprite.body.y, 'bullet')
    bullets.setAll('checkWorldBounds', true)
    bullets.setAll('outOfBoundsKill', true)
    game.physics.arcade.moveToPointer(bullet, 300)


  crash: (player) ->
    game.add.text(301, 301, 'GAME OVER', { fontSize: '64px', fill: '#fff' })
    game.add.text(300, 300, 'GAME OVER', { fontSize: '64px', fill: '#f00' })
    player.kill()
    window.gameOver = true
