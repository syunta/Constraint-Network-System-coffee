cons = (x, y) ->
  dispatch = (m) ->
    if m is "car"
      x
    else if m is "cdr"
      y
    else
      throw new Error "Undefined operation -- CONS", m
  dispatch

car = (z) -> z "car"
cdr = (z) -> z "cdr"

module.exports =
  cons: cons
  car : car
  cdr : cdr
