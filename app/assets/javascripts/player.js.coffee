class @Player
  constructor: ->
    @score = 0
    @coins = 0
    @speed = 10
    @maxSpeed = 150
    @Gun = new Gun

  createSprite: ->
    @CollisionGroup = game.physics.p2.createCollisionGroup()
    @sprite = game.add.sprite(200,200, 'ship1')
    game.physics.p2.enable(@sprite)
    game.camera.follow(@sprite)
    @sprite.body.setRectangle 17, 35
    @sprite.animations.add('thrust', [1, 2, 3, 4], 10, true)
    @sprite.body.collideWorldBounds = true
    @sprite.anchor.set(0.5)
    @sprite.body.setCollisionGroup(@CollisionGroup)
    @sprite.body.collides(coinsCollisionGroup, Player.collect, this)
    @sprite.body.collides(baddiesCollisionGroup, Player.crash, this)

  fire: -> @Gun.fire(@sprite.body.x, @sprite.body.y)

  crash: (object) ->
    Text.addGameOver()
    window.Player.sprite.kill()
    window.gameOver = true

  collect: (itemBody) ->
    window.Player.coins += 1
    itemBody.sprite.kill()

  reset: ->
    @sprite.kill()
    @score = 0
    @createSprite()

  rotateRight: -> @sprite.body.rotateRight(100)
  rotateLeft:  -> @sprite.body.rotateLeft(100)
  noRotate:    -> @sprite.body.setZeroRotation()

  accelerate: ->
    @sprite.animations.play('thrust', 30, true)
    @sprite.body.thrust(400)

  decelerate: ()->
    @sprite.animations.stop()
    @sprite.frame = 0

  brake: ()->
    @sprite.animations.stop()
    @sprite.frame = 0
