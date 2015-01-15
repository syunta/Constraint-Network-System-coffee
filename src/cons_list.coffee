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

module.exports =
  cons: cons
  car : car
  cdr : cdr
  setCar : setCar
  setCdr : setCdr
