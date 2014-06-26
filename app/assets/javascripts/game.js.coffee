$ -> init()

@init = ->
  window.preload = ->
    game.load.image('sky', 'assets/sky.png')
    game.load.image('ground', 'assets/platform.png')
    game.load.image('star', 'assets/star.png')
    game.load.spritesheet('dude', 'assets/dude.png', 32, 48)

  window.create = ->
    game.physics.startSystem Phaser.Physics.ARCADE

    game.add.sprite(0,0, 'sky')

    window.platforms = game.add.group()
    platforms.enableBody = true

    ground = platforms.create(0, game.world.height - 64, 'ground')
    ground.scale.setTo(2, 2)
    ground.body.immovable = true

    ledge = platforms.create(400, 400, 'ground')
    ledge.body.immovable = true
    ledge = platforms.create(-150, 250, 'ground')
    ledge.body.immovable = true

    window.player = game.add.sprite(32, game.world.height - 150, 'dude')
    game.physics.arcade.enable(player)
    player.body.bounce.y = 0.2
    player.body.gravity.y = 300
    player.body.collideWorldBounds = true
    player.animations.add('left', [0, 1, 2, 3], 10, true)
    player.animations.add('right', [5, 6, 7, 8], 10, true)

    window.cursors = game.input.keyboard.createCursorKeys()

    window.stars = game.add.group()
    stars.enableBody = true

    for i in [0..12]
      star = stars.create(i * 70, 0, 'star')
      star.body.gravity.y = 6
      star.body.bounce.y = 0.7 + (Math.random() * 0.2)

    window.score = 0
    window.scoreText = game.add.text 16, 16, 'score: 0', {fontSize: '32px', fill: '#000'}


  window.update = ->
    game.physics.arcade.collide(player, platforms)
    game.physics.arcade.collide(stars, platforms)
    game.physics.arcade.overlap(player, stars, collectStar, null, this)

    player.body.velocity.x = 0
    if cursors.left.isDown
      player.body.velocity.x = -150
      player.animations.play 'left'
    else if cursors.right.isDown
      player.body.velocity.x = 150
      player.animations.play 'right'
    else
      player.animations.stop()
      player.frame = 4

    if cursors.up.isDown && player.body.touching.down
      player.body.velocity.y = -350

  window.collectStar = (player, star) ->
    star.kill()
    score += 10
    scoreText.text = "Score: #{score}"

  window.game = new Phaser.Game(800,600, Phaser.AUTO, "", {preload: preload, create: create, update: update})

