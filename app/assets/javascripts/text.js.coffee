class Text
  constructor: ->

  init: ->
    @scoreText = game.add.text(16, 16, "Score: #{Player.score}",
      { font: '32px helvetica', fill: '#fff' })
    @levelText = game.add.text(16, 42, "Level: #{level}",
      { font: '12px helvetica', fill: '#fff' })
    @coinsText = game.add.text(16, 42, "Coins: #{Player.coins}",
      { font: '12px helvetica', fill: '#fff' })
    @scoreText.fixedToCamera = true
    @scoreText.cameraOffset.setTo(0,0)
    @levelText.fixedToCamera = true
    @levelText.cameraOffset.setTo(0,40)
    @coinsText.fixedToCamera = true
    @coinsText.cameraOffset.setTo(0,60)

  addGameOver: ->
    @gameOverText = game.add.text(1, 1, 'GAME OVER',
      { fontSize: '64px', fill: '#fff' })
    @gameOverText.fixedToCamera = true
    @gameOverText.cameraOffset.setTo(300,300)
    @gameOverText.setShadow(3, 3, 'rgba(0,0,0,0.5)', 5)

    @resetButton = game.add.button(0, 0, 'yellow_button',
      resetWorld, this, 2, 1, 0)
    @resetButtonText = game.add.text(1, 1, 'Try Again',
      { font: '16px helvetica', fill: '#000' })
    @resetButton.fixedToCamera = true
    @resetButton.cameraOffset.setTo(320,350)
    @resetButtonText.fixedToCamera = true
    @resetButtonText.cameraOffset.setTo(335,355)

    @showStoreButtons()

  showStoreButtons: ->
    @rofButton = game.add.button(0, 0, 'yellow_button',
      Store.upgradeRateOfFire, this, 2, 1, 0)
    @rofButtonText = game.add.text(1, 1, 'Upgrade Rate of Fire',
      { font: '12px helvetica', fill: '#000' })
    @rofButton.fixedToCamera = true
    @rofButton.cameraOffset.setTo(320,380)
    @rofButtonText.fixedToCamera = true
    @rofButtonText.cameraOffset.setTo(335,385)

    @bulletSpeedButton = game.add.button(0, 0, 'yellow_button',
      Store.upgradeBulletSpeed, this, 2, 1, 0)
    @bulletSpeedButtonText = game.add.text(1, 1, 'Upgrade Bullet Speed',
      { font: '12px helvetica', fill: '#000' })
    @bulletSpeedButton.fixedToCamera = true
    @bulletSpeedButton.cameraOffset.setTo(320,470)
    @bulletSpeedButtonText.fixedToCamera = true
    @bulletSpeedButtonText.cameraOffset.setTo(335,475)

    @speedButton = game.add.button(0, 0, 'yellow_button',
      Store.upgradeSpeed, this, 2, 1, 0)
    @speedButtonText = game.add.text(1, 1, 'Upgrade Speed',
      { font: '12px helvetica', fill: '#000' })
    @speedButton.fixedToCamera = true
    @speedButton.cameraOffset.setTo(320,410)
    @speedButtonText.fixedToCamera = true
    @speedButtonText.cameraOffset.setTo(335,415)

    @maxSpeedButton = game.add.button(0, 0, 'yellow_button',
      Store.upgradeMaxSpeed, this, 2, 1, 0)
    @maxSpeedButtonText = game.add.text(1, 1, 'Upgrade Max Speed',
      { font: '12px helvetica', fill: '#000' })
    @maxSpeedButton.fixedToCamera = true
    @maxSpeedButton.cameraOffset.setTo(320,440)
    @maxSpeedButtonText.fixedToCamera = true
    @maxSpeedButtonText.cameraOffset.setTo(335,445)

  removeGameOver: ->
    @gameOverText.destroy()
    @resetButton.destroy()
    @resetButtonText.destroy()
    @destroyStoreButtons()

  destroyStoreButtons: ->
    @rofButton.destroy()
    @rofButtonText.destroy()
    @speedButton.destroy()
    @speedButtonText.destroy()
    @maxSpeedButton.destroy()
    @maxSpeedButtonText.destroy()
    @bulletSpeedButton.destroy()
    @bulletSpeedButtonText.destroy()
    @insufficientFundsText.destroy()

  update: ->
    @updateScore()
    @updateLevel()
    @updateCoins()

  updateScore: ->
    @scoreText.text = "Score: #{Player.score}"

  updateLevel: ->
    window.level = Math.floor(Player.score / 100) + 1
    @levelText.text = 'Level: ' + level

  updateCoins: ->
    @coinsText.text = "Coins: #{Player.coins}"

  insufficientFunds: ->
    @insufficientFundsText = game.add.text(1, 1, 'Insufficient Funds',
      { fontSize: '164px', fill: '#f00' })
    @insufficientFundsText.fixedToCamera = true
    @insufficientFundsText.cameraOffset.setTo(200,200)

window.Text = new Text
