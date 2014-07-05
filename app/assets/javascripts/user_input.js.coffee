class UserInput
  handle: ->
    Player.fire() if game.input.activePointer.isDown
    Player.sprite.rotation = game.physics.arcade.angleToPointer(Player.sprite)
    if game.input.keyboard.isDown(Phaser.Keyboard.A)
      Player.rotateLeft()
    else if game.input.keyboard.isDown(68)
      Player.rotateRight()
    else
      Player.noRotate()
    if game.input.keyboard.isDown(Phaser.Keyboard.W)
      Player.accelerate()
    else if game.input.keyboard.isDown(Phaser.Keyboard.S)
      Player.brake()
    else
      Player.decelerate()

window.UserInput = new UserInput
