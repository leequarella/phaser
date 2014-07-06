$ -> init()

@init = ->
  window.game = new Phaser.Game(800,600, Phaser.AUTO, "",
    {preload: Game.preload, create: Game.create, update: Game.update})

class Game
  @preload: ->
    game.load.image('background',    'assets/starfield.jpg')
    game.load.image('bullet',        'assets/star.png')
    game.load.image('reset_button',  'assets/reset_button.png')
    game.load.image('yellow_button', 'assets/yellow_button.png')
    game.load.image('player',        'assets/ship.png')
    game.load.image('dude1',         'assets/baddie_ball.png')
    game.load.image('dude2',         'assets/dude_single.png')
    game.load.image('coin',          'assets/coin.png')
    game.load.spritesheet('ship1',   'assets/ship_anim.png', 17, 30)

  @create: ->
    setupWorld()
    createCollisionGroups()
    window.Player = new Player
    Player.createSprite()
    Text.init()
    createGroups()

  @update: ->
    Spawn.baddies()
    UserInput.handle()
    Text.update()
    for coin in coins.children
      if Phaser.distanceBetween(coin, Player.sprite) < 200
        Phaser.accelerateToObject(coin, Player.sprite, 100)

    stopAtWorldBounds(Player.sprite)
window.Game = new Game

@stopAtWorldBounds = (sprite) ->
  #console.log sprite.body.x, game.world.bounds.x
  if (sprite.body.x < 0)
    sprite.body.setZeroVelocity()
    sprite.body.x = 1
  else if (sprite.body.x > game.world.bounds.width)
    sprite.body.setZeroVelocity()
    sprite.body.x = game.world.bounds.width
  if (sprite.body.y < 0)
    sprite.body.setZeroVelocity()
    sprite.body.y = 1
  else if (sprite.body.y > game.world.bounds.height)
    sprite.body.setZeroVelocity()
    sprite.body.y = game.world.bounds.height

@setupWorld = ->
  game.add.tileSprite(0, 0, 2000, 2000, 'background')
  game.world.setBounds(0, 0, 1400, 1400)
  window.level = 1
  window.gameOver = false
  game.physics.startSystem Phaser.Physics.P2JS
  game.physics.p2.setImpactEvents(true)

@createCollisionGroups = ->
  window.coinsCollisionGroup  = game.physics.p2.createCollisionGroup()
  window.bulletsCollisionGroup  = game.physics.p2.createCollisionGroup()
  window.baddiesCollisionGroup  = game.physics.p2.createCollisionGroup()

@createGroups = ->
  window.bullets = game.add.group()
  window.coins = game.add.group()
  window.dudes = game.add.group()

@resetWorld = ->
  Player.reset()
  window.gameOver = false
  try Text.removeGameOver()


@dudeKill = (dude, bullet)->
  itemDrop(dude.sprite.body.x, dude.sprite.body.y)
  bullet.sprite.kill()
  dude.sprite.kill()
  Player.score += 10

@itemDrop = (x, y) ->
  coin = coins.create(x, y, 'coin')
  game.physics.p2.enable coin, false
  setTimeout (=> coin.kill()), 5000
  coin.body.setCircle 10
  coin.scale.set(0.25)
  coin.body.setCollisionGroup(coinsCollisionGroup)
  coin.body.collides([Player.CollisionGroup], Player.collect, this)
  coinMaterial = game.physics.p2.createMaterial('coinMaterial', coin.body)
  playerMaterial = game.physics.p2.createMaterial('playerMaterial', Player.sprite.body)
  playerCoinContact= game.physics.p2.createContactMaterial(coinMaterial, playerMaterial)
  playerCoinContact.restitution = 0.1
