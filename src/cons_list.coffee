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

module.exports =
  cons: cons
  car : car
  cdr : cdr
  cadr : cadr
  cddr : cddr
  setCar : setCar
  setCdr : setCdr
