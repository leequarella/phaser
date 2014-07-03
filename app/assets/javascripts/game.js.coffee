$ -> init()

@init = ->
  window.game = new Phaser.Game(800,600, Phaser.AUTO, "", {preload: preload, create: create, update: update})

@preload = ->
  game.load.image('sky',        'assets/sky.png')
  game.load.image('ground',     'assets/platform.png')
  game.load.image('bullet',     'assets/star.png')
  game.load.image('player',     'assets/ship.png')
  game.load.spritesheet('dude', 'assets/dude.png', 32, 48)

@create = ->
  window.score = 0
  window.scoreText = game.add.text(16, 16, 'score: 0', { fontSize: '32px', fill: '#fff' })
  game.physics.startSystem Phaser.Physics.ARCADE

  window.dudes = game.add.group()
  dudes.enableBody = true

  window.player = game.add.sprite(200,200, 'player')
  game.physics.arcade.enable(player)
  player.body.collideWorldBounds = true
  player.anchor.set(0.5)

  window.cursors = game.input.keyboard.createCursorKeys()

  window.bullets = game.add.group()
  bullets.enableBody = true
  bullets.physicsBodyType = Phaser.Physics.ARCADE
  window.lastFired = Date.now()


@update = ->
  game.physics.arcade.collide(bullets, dudes)
  game.physics.arcade.overlap(bullets, dudes, dudeKill, null, this)
  game.physics.arcade.overlap(player, dudes, playerCrash, null, this)
  addDude() if dudes.total < 1
  player.rotation = game.physics.arcade.angleToPointer(player)
  fire() if game.input.activePointer.isDown
  if game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR)
    fire()
  if cursors.left.isDown || game.input.keyboard.isDown(Phaser.Keyboard.A)
    accelerate(player, 'x', '-')
    player.animations.play 'left'
  else if cursors.right.isDown || game.input.keyboard.isDown(68)
    accelerate(player, 'x', '+')
    player.animations.play 'right'
  else
    decelerate(player, 'x')
    player.animations.stop()
    player.frame = 4

  if cursors.up.isDown || game.input.keyboard.isDown(Phaser.Keyboard.W)
    accelerate(player, 'y', '-')
  else if cursors.down.isDown || game.input.keyboard.isDown(Phaser.Keyboard.S)
    accelerate(player, 'y', '+')
  else
    decelerate(player, 'y')
  scoreText.text = 'Score: ' + score

@addDude = ->
  x = Math.random() * game.width
  y = Math.random() * game.height
  dude = dudes.create(x, y, 'dude')
  dude.enableBody = true
  dude.body.bounce = 0.7

@accelerate = (object, coord, magnitude) ->
  if magnitude == "+"
    object.body.velocity[coord] += 10 unless object.body.velocity[coord] > 150
  else
    object.body.velocity[coord] -= 10 unless object.body.velocity[coord] < -150

@decelerate = (object, coord)->
  if object.body.velocity[coord] > 0
    object.body.velocity[coord] -= 1
  else if object.body.velocity[coord] < 0
    object.body.velocity[coord] += 1

@fire = ->
  return if lastFired > Date.now() - 400
  window.lastFired = Date.now()
  bullet = bullets.create(player.body.x, player.body.y, 'bullet')
  bullets.setAll('checkWorldBounds', true)
  bullets.setAll('outOfBoundsKill', true)
  game.physics.arcade.moveToPointer(bullet, 300)

@dudeKill = (bullet, dude)->
  bullet.kill()
  dude.kill()
  score += 10

@playerCrash = ->
  console.log 'Player crashed.'
