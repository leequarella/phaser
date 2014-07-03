$ -> init()

@init = ->
  window.game = new Phaser.Game(800,600, Phaser.AUTO, "", {preload: preload, create: create, update: update})
  window.Player = new Player

@preload = ->
  game.load.image('sky',        'assets/sky.png')
  game.load.image('ground',     'assets/platform.png')
  game.load.image('bullet',     'assets/star.png')
  game.load.image('player',     'assets/ship.png')
  game.load.image('dude1', 'assets/baddie_ball.png')
  game.load.image('dude2', 'assets/dude_single.png')

@create = ->
  window.gameOver = false
  window.score = 0
  window.level = 1
  window.scoreText = game.add.text(16, 16, "Score: #{score}", { fontSize: '32px', fill: '#fff' })
  window.levelText = game.add.text(16, 42, "Level: #{level}", { fontSize: '12px', fill: '#fff' })
  game.physics.startSystem Phaser.Physics.ARCADE

  window.dudes = game.add.group()
  dudes.enableBody = true

  Player.createSprite()

  window.cursors = game.input.keyboard.createCursorKeys()

  window.bullets = game.add.group()
  bullets.enableBody = true
  bullets.physicsBodyType = Phaser.Physics.ARCADE

@update = ->
  handleCollisions()
  Spawn.baddies()
  UserInput.handle()
  updateScore()
  updateLevel()

@updateScore = ->
  scoreText.text = 'Score: ' + score

@updateLevel = ->
  window.level = Math.floor(score / 100) + 1
  levelText.text = 'Level: ' + level

@handleCollisions = ->
  game.physics.arcade.overlap(bullets, dudes, dudeKill, null, this)
  game.physics.arcade.overlap(Player.sprite, dudes, Player.crash, null, this)

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

@dudeKill = (bullet, dude)->
  bullet.kill()
  dude.kill()
  score += 10

