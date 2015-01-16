cons = require('./cons_list').cons
car = require('./cons_list').car
cdr = require('./cons_list').cdr
setCar = require('./cons_list').setCar
setCdr = require('./cons_list').setCdr

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

module.exports.memq = memq
module.exports.forEachExcept = forEachExcept
