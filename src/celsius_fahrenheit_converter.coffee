makeConnector = require('./constraint_network').makeConnector
adder = require('./constraint_network').adder
constant = require('./constraint_network').constant
multiplier = require('./constraint_network').multiplier

# 9C = 5(F-32)

celsiusFahrenheitConverter = (c, f) ->
  do (
    u = do makeConnector,
    v = do makeConnector,
    w = do makeConnector,
    x = do makeConnector,
    y = do makeConnector
  ) ->
    (multiplier c, w, u)
    (multiplier v, x, u)
    (adder v, y, f)
    (constant 9, w)
    (constant 5, x)
    (constant 32, y)
    'ok'

module.exports.celsiusFahrenheitConverter = celsiusFahrenheitConverter
