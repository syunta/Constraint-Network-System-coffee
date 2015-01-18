cons = (x, y) ->
  setX = (v) -> x = v
  setY = (v) -> y = v
  dispatch = (m) ->
    switch m
      when 'car'    then x
      when 'cdr'    then y
      when 'setCar' then setX
      when 'setCdr' then setY
      else throw new Error "Undefined operation -- CONS #{m}"
  dispatch

car = (z) -> z 'car'
cdr = (z) -> z 'cdr'

setCar = (z, newValue) -> ((z 'setCar') newValue)
setCdr = (z, newValue) -> ((z 'setCdr') newValue)

cadr = (z) -> (car (cdr z))
cddr = (z) -> (cdr (cdr z))

module.exports.cons = cons
module.exports.car = car
module.exports.cdr = cdr
module.exports.cadr = cadr
module.exports.cddr = cddr
module.exports.setCar = setCar
module.exports.setCdr = setCdr
