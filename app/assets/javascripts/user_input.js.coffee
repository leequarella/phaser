class UserInput
  handle: ->
    Player.fire() if game.input.activePointer.isDown
    Player.sprite.rotation = game.physics.arcade.angleToPointer(Player.sprite)
    if game.input.keyboard.isDown(Phaser.Keyboard.A)
      accelerate(Player.sprite, 'x', '-')
    else if game.input.keyboard.isDown(68)
      accelerate(Player.sprite, 'x', '+')
    else
      decelerate(Player.sprite, 'x')
    if game.input.keyboard.isDown(Phaser.Keyboard.W)
      accelerate(Player.sprite, 'y', '-')
    else if game.input.keyboard.isDown(Phaser.Keyboard.S)
      accelerate(Player.sprite, 'y', '+')
    else
      decelerate(Player.sprite, 'y')

window.UserInput = new UserInput
