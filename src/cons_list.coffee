cons = (x, y) ->
  setX = (v) -> x = v
  setY = (v) -> y = v
  dispatch = (m) ->
    switch m
      when "car"    then x
      when "cdr"    then y
      when "setCar" then setX
      when "setCdr" then setY
      else throw new Error "Undefined operation -- CONS"
  dispatch

car = (z) -> z "car"
cdr = (z) -> z "cdr"

setCar = (z, newValue) -> ((z "setCar") newValue)
setCdr = (z, newValue) -> ((z "setCdr") newValue)

cadr = (z) -> (car (cdr z))
cddr = (z) -> (cdr (cdr z))

memq = (item, x) ->
  if x is null
    false
  else if item is car x
    x
  else
    (memq item, (cdr x))

forEachExcept = (exception, procedure, list) ->
  go = (items) ->
    if items is null
      "done"
    else if (car items) is exception
      (go (cdr items))
    else
      (procedure (car items))
      (go (cdr items))
  go list

module.exports.cons = cons
module.exports.car = car
module.exports.cdr = cdr
module.exports.cadr = cadr
module.exports.cddr = cddr
module.exports.setCar = setCar
module.exports.setCdr = setCdr
module.exports.memq = memq
module.exports.forEachExcept = forEachExcept
