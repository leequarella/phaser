class @Player
  constructor: ->
    @score = 0
    @coins = 0
    @speed = 10
    @maxSpeed = 150
    @Gun = new Gun

  createSprite: ->
    @sprite = game.add.sprite(200,200, 'player')
    game.physics.arcade.enable(@sprite)
    @sprite.body.collideWorldBounds = true
    @sprite.anchor.set(0.5)
    game.camera.follow(@sprite)

  fire: -> @Gun.fire(@sprite.body.x, @sprite.body.y)

  crash: (playerSprite) ->
    Text.addGameOver()
    playerSprite.kill()
    window.gameOver = true

  collect: (playerSprite, coin) ->
    window.Player.coins += 1
    coin.kill()

  reset: ->
    @sprite.kill()
    @score = 0
    @createSprite()

  accelerate: (coord, magnitude) ->
    if magnitude == "+"
      @sprite.body.velocity[coord] += @speed unless @sprite.body.velocity[coord] > @maxSpeed
    else
      @sprite.body.velocity[coord] -= @speed unless @sprite.body.velocity[coord] < (-1 * @maxSpeed)

  decelerate: (object, coord)->
    if @sprite.body.velocity[coord] > 0
      @sprite.body.velocity[coord] -= 1
    else if @sprite.body.velocity[coord] < 0
      @sprite.body.velocity[coord] += 1
