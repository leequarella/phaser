class UserInput
  handle: ->
    Player.fire() if game.input.activePointer.isDown
    Player.sprite.rotation = game.physics.arcade.angleToPointer(Player.sprite)
    if game.input.keyboard.isDown(Phaser.Keyboard.A)
      Player.accelerate('x', '-')
    else if game.input.keyboard.isDown(68)
      Player.accelerate('x', '+')
    else
      Player.decelerate('x')
    if game.input.keyboard.isDown(Phaser.Keyboard.W)
      Player.accelerate('y', '-')
    else if game.input.keyboard.isDown(Phaser.Keyboard.S)
      Player.accelerate('y', '+')
    else
      Player.decelerate('y')

window.UserInput = new UserInput
