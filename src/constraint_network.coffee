cons = require('./cons_list').cons
car = require('./cons_list').car
cdr = require('./cons_list').cdr
setCar = require('./cons_list').setCar
setCdr = require('./cons_list').setCdr
memq = require('./cons_list_proc').memq
forEachExcept = require('./cons_list_proc').forEachExcept

adder = (a1, a2, sum) ->
  processNewValue = () -> #TODO
  processForgetValue () -> #TODO
  me = (request) ->
    switch request
      when "I-have-a-value"  then processNewValue
      when "I-lost-my-value" then processForgetValue
      else throw new Error "Unknown request -- ADDER"
  me

makeConnector = () ->
  do (value = false, informant = false, constraints = null) ->
    setMyValue = () -> #TODO
    forgetMyValue = () -> #TODO
    connect = () -> #TODO
    me = (request) ->
      switch request
        when "value"    then value
        when "setValue" then setMyValue
        when "forget"   then forgetMyValue
        when "connect"  then connect
        else throw new Error "Unknown operation -- CONNECTOR"
    me

module.exports.makeConnector = makeConnector
