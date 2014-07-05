class Spawn
  baddies: ->
    return if dudes.total > level
    @generateRandomCoords()
    return @baddies() if @tooCloseToPlayer(@x, @y, Player.sprite)
    dude = dudes.create(@x, @y, @randomArt())
    game.physics.p2.enable dude, false
    dude.body.setRectangle 30, 30
    dude.body.setCollisionGroup(baddiesCollisionGroup)
    dude.body.collides([Player.CollisionGroup], Player.crash, this)
    dude.body.collides([bulletsCollisionGroup], dudeKill, this)
    @setOutOfBoundsKill(dudes)
    @setRandomVelocity(dude)
    @baddies()

  randomArt: ->
    dudeArt = if Math.random() < 0.5 then 'dude1' else 'dude2'

  generateRandomCoords: ->
    @x = Math.random() * game.width
    @y = Math.random() * game.height

  setRandomVelocity: (object) ->
    vx = Math.random() * 200
    vx *= -1 if Math.random() > 0.5
    vy = Math.random() * 200
    vy *= -1 if Math.random() > 0.5
    object.body.velocity.x = vx
    object.body.velocity.y = vy

  setOutOfBoundsKill: (collection) ->
    collection.setAll('checkWorldBounds', true)
    collection.setAll('outOfBoundsKill', true)

  tooCloseToPlayer: (x, y, player) ->
    if player.body.x - 100 < x  && x < player.body.x + 100
      true
    else if player.body.y - 100 < y && y < player.body.y + 100
      true
    else
      false


window.Spawn = new Spawn
