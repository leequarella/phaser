class Player
  constructor: ->
    @coins = 0
    @rateOfFire = 2
    @lastFired = Date.now()

  createSprite: ->
    @sprite = game.add.sprite(200,200, 'player')
    game.physics.arcade.enable(@sprite)
    @sprite.body.collideWorldBounds = true
    @sprite.anchor.set(0.5)
    game.camera.follow(@sprite)

  fire: ->
    return if (@lastFired > Date.now() - (1000/@rateOfFire)) || gameOver
    @lastFired = Date.now()
    bullet = bullets.create(@sprite.body.x, @sprite.body.y, 'bullet')
    bullets.setAll('checkWorldBounds', true)
    bullets.setAll('outOfBoundsKill', true)
    game.physics.arcade.moveToPointer(bullet, 300)

  crash: (playerSprite) ->
    gameOverText = game.add.text(301, 301, 'GAME OVER', { fontSize: '64px', fill: '#fff' })
    gameOverTextShadow = game.add.text(300, 300, 'GAME OVER', { fontSize: '64px', fill: '#f00' })
    gameOverText.fixedToCamera = true
    gameOverText.cameraOffset.setTo(300,300)
    gameOverTextShadow.fixedToCamera = true
    gameOverTextShadow.cameraOffset.setTo(301,301)
    playerSprite.kill()
    window.gameOver = true

  collect: (playerSprite, coin) ->
    window.Player.coins += 1
    coin.kill()

window.Player = new Player
