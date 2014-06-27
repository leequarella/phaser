$ -> init()

@init = ->
  window.game = new Phaser.Game(800,600, Phaser.AUTO, "", {preload: preload, create: create, update: update})

@preload = ->
  game.load.image('sky', 'assets/sky.png')
  game.load.image('ground', 'assets/platform.png')
  game.load.image('bullet', 'assets/star.png')
  game.load.spritesheet('dude', 'assets/dude.png', 32, 48)

@create = ->
  game.physics.startSystem Phaser.Physics.ARCADE

  game.add.sprite(0,0, 'sky')

  window.platforms = game.add.group()
  platforms.enableBody = true

  window.player = game.add.sprite(32, game.world.height - 150, 'dude')
  game.physics.arcade.enable(player)
  player.body.collideWorldBounds = true
  player.animations.add('left', [0, 1, 2, 3], 10, true)
  player.animations.add('right', [5, 6, 7, 8], 10, true)

  window.cursors = game.input.keyboard.createCursorKeys()

  window.bullets = game.add.group()
  bullets.enableBody = true
  window.lastFired = Date.now()

@update = ->
  if game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR)
    fire()
  if cursors.left.isDown
    accelerate('x', '-')
    player.animations.play 'left'
  else if cursors.right.isDown
    accelerate('x', '+')
    player.animations.play 'right'
  else
    decelerate('x')
    player.animations.stop()
    player.frame = 4

  if cursors.up.isDown
    accelerate('y', '-')
  else if cursors.down.isDown
    accelerate('y', '+')
  else
    decelerate('y')

@accelerate = (coord, magnitude) ->
  if magnitude == "+"
    player.body.velocity[coord] += 10 unless player.body.velocity[coord] > 150
  else
    player.body.velocity[coord] -= 10 unless player.body.velocity[coord] < -150

@decelerate = (coord)->
  if player.body.velocity[coord] > 0
    player.body.velocity[coord] -= 1
  else if player.body.velocity[coord] < 0
    player.body.velocity[coord] += 1

@fire = ->
  return if lastFired > Date.now() - 100
  window.lastFired = Date.now()
  bullet = bullets.create(player.body.x, player.body.y, 'bullet')
  if player.body.velocity.x > 0
    bullet.body.velocity.x = player.body.velocity.x + 100
  else
    bullet.body.velocity.x = player.body.velocity.x - 100

  if player.body.velocity.y > 0
    bullet.body.velocity.y = player.body.velocity.y + 100
  else
    bullet.body.velocity.y = player.body.velocity.y - 100
