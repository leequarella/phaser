class Spawn
  baddies: ->
    return if dudes.total > level
    x = Math.random() * game.width
    y = Math.random() * game.height
    return @baddies() if @tooCloseToPlayer(x, y, Player.sprite)
    vx = Math.random() * 200
    vx *= -1 if Math.random() > 0.5
    vy = Math.random() * 200
    vy *= -1 if Math.random() > 0.5
    dudeArt = if Math.random() < 0.5 then 'dude1' else 'dude2'
    dude = dudes.create(x, y, dudeArt)
    dude.enableBody = true
    dudes.setAll('checkWorldBounds', true)
    dudes.setAll('outOfBoundsKill', true)
    dude.body.velocity.x = vx
    dude.body.velocity.y = vy
    game.physics.arcade.collide(Player.sprite, dudes)
    @baddies()

  tooCloseToPlayer: (x, y, player) ->
    if player.body.x - 100 < x  && x < player.body.x + 100
      true
    else if player.body.y - 100 < y && y < player.body.y + 100
      true
    else
      false


window.Spawn = new Spawn
