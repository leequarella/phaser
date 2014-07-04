class Store
  upgradeRateOfFire: (amount) ->
    return Text.insufficientFunds() if Player.coins < 1
    Player.coins -= 1
    Player.Gun.rateOfFire += parseInt(amount) || 1

  upgradeBulletSpeed: (amount) ->
    return Text.insufficientFunds() if Player.coins < 1
    Player.coins -= 1
    Player.Gun.bulletSpeed += parseInt(amount) || 1

  upgradeSpeed: (amount) ->
    return Text.insufficientFunds() if Player.coins < 1
    Player.coins -= 1
    Player.speed += parseInt(amount) || 1

  upgradeMaxSpeed: (amount) ->
    return Text.insufficientFunds() if Player.coins < 1
    Player.coins -= 1
    Player.maxSpeed += parseInt(amount) || 1

window.Store = new Store
