$ -> init()

@init = ->
  window.game = new Phaser.Game(800,600, Phaser.AUTO, "",
    {preload: preload, create: create, update: update})

@preload = ->
  game.load.image('background',    'assets/starfield.jpg')
  game.load.image('bullet',        'assets/star.png')
  game.load.image('reset_button',  'assets/reset_button.png')
  game.load.image('yellow_button', 'assets/yellow_button.png')
  game.load.image('player',        'assets/ship.png')
  game.load.image('dude1',         'assets/baddie_ball.png')
  game.load.image('dude2',         'assets/dude_single.png')
  game.load.image('coin',          'assets/coin.png')

@create = ->
  setupWorld()

  window.Player = new Player
  Player.createSprite()

  Text.init()

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
  window.level = 1
  window.gameOver = false
  game.physics.startSystem Phaser.Physics.ARCADE

@resetWorld = ->
  Player.reset()
  window.gameOver = false
  try Text.removeGameOver()

@createBaddies = ->
  window.dudes = game.add.group()
  dudes.enableBody = true

@update = ->
  handleCollisions()
  Spawn.baddies()
  UserInput.handle()
  Text.update()

@handleCollisions = ->
  game.physics.arcade.overlap(bullets, dudes, dudeKill, null, this)
  game.physics.arcade.overlap(Player.sprite, coins, Player.collect, null, this)
  game.physics.arcade.overlap(Player.sprite, dudes, Player.crash, null, this)

@dudeKill = (bullet, dude)->
  itemDrop(dude.body.x, dude.body.y)
  bullet.kill()
  dude.kill()
  Player.score += 10

@itemDrop = (x, y) ->
  coin = coins.create(x, y, 'coin')
  coin.enableBody = true
  setTimeout (=> coin.kill()), 5000
  coin.scale.x = 0.3
  coin.scale.y = 0.3
