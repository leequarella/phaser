$ -> init()

@init = ->
  window.game = new Phaser.Game(800,600, Phaser.AUTO, "",
    {preload: preload, create: create, update: update})

@preload = ->
  game.load.image('background', 'assets/starfield.jpg')
  game.load.image('bullet',     'assets/star.png')
  game.load.image('player',     'assets/ship.png')
  game.load.image('dude1',      'assets/baddie_ball.png')
  game.load.image('dude2',      'assets/dude_single.png')
  game.load.image('coin',       'assets/coin.png')

@create = ->
  setupWorld()
  setupText()

  Player.createSprite()
  createBaddies()
  createBullets()
  createCoins()

@createBullets = ->
  window.bullets = game.add.group()
  bullets.enableBody = true
  bullets.physicsBodyType = Phaser.Physics.ARCADE

@createCoins = ->
  window.coins = game.add.group()
  coins.enableBody = true
  coins.physicsBodyType = Phaser.Physics.ARCADE

@setupWorld = ->
  game.add.tileSprite(0, 0, 2000, 2000, 'background')
  game.world.setBounds(0, 0, 1400, 1400)
  window.score = 0
  window.level = 1
  window.gameOver = false
  game.physics.startSystem Phaser.Physics.ARCADE

@setupText = ->
  window.scoreText = game.add.text(16, 16, "Score: #{score}",
    { font: '32px helvetica', fill: '#fff' })
  window.levelText = game.add.text(16, 42, "Level: #{level}",
    { font: '12px helvetica', fill: '#fff' })
  window.coinsText = game.add.text(16, 42, "Coins: #{Player.coins}",
    { font: '12px helvetica', fill: '#fff' })
  scoreText.fixedToCamera = true
  scoreText.cameraOffset.setTo(0,0)
  levelText.fixedToCamera = true
  levelText.cameraOffset.setTo(0,40)
  coinsText.fixedToCamera = true
  coinsText.cameraOffset.setTo(0,60)

@createBaddies = ->
  window.dudes = game.add.group()
  dudes.enableBody = true

@update = ->
  handleCollisions()
  Spawn.baddies()
  UserInput.handle()
  updateScore()
  updateLevel()
  updateCoins()

@updateScore = ->
  scoreText.text = 'Score: ' + score

@updateLevel = ->
  window.level = Math.floor(score / 100) + 1
  levelText.text = 'Level: ' + level

@updateCoins = ->
  coinsText.text = "Coins: #{Player.coins}"

@handleCollisions = ->
  game.physics.arcade.overlap(bullets, dudes, dudeKill, null, this)
  game.physics.arcade.overlap(Player.sprite, coins, Player.collect, null, this)
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
  itemDrop(dude.body.x, dude.body.y)
  bullet.kill()
  dude.kill()
  score += 10

@itemDrop = (x, y) ->
  coin = coins.create(x, y, 'coin')
  coin.enableBody = true
  coin.scale.x = 0.3
  coin.scale.y = 0.3
