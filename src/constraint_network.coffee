cons = require('./cons_list').cons
car = require('./cons_list').car
cdr = require('./cons_list').cdr
setCar = require('./cons_list').setCar
setCdr = require('./cons_list').setCdr
memq = require('./cons_list_proc').memq
forEachExcept = require('./cons_list_proc').forEachExcept

informAboutValue = (constraint) ->
  constraint "I-have-a-value"

informAboutNoValue = (constraint) ->
  constraint "I-lost-my-value"

hasValue = (connector) ->
  connector "has-value?"

getValue = (connector) ->
  connector "value"

adder = (a1, a2, sum) ->
  processNewValue = () -> #TODO
  processForgetValue = () -> #TODO
  me = (request) ->
    switch request
      when "I-have-a-value"  then processNewValue
      when "I-lost-my-value" then processForgetValue
      else throw new Error "Unknown request -- ADDER"
  me

makeConnector = () ->
  do (value = false, informant = false, constraints = null) ->

    setMyValue = (newval, setter) ->
      if not (hasValue me)
        value = newval
        informant = setter
        forEachExcept setter,
                      informAboutValue,
                      constraints
      else if value isnt newval
        throw new Error "Contradiction (#{value} #{newval})"
      else
        "ignored"

    forgetMyValue = (retractor) ->
      if retractor is informant
        informant = false
        forEachExcept retractor,
                      informAboutNoValue,
                      constraints
      else
        "ignored"

    connect = () -> #TODO

    me = (request) ->
      switch request
        when "has-value?"
          if informant then true else false
        when "value"       then value
        when "constraints" then constraints # open for test code
        when "set-value!"  then setMyValue
        when "forget"      then forgetMyValue
        when "connect"     then connect
        else throw new Error "Unknown operation -- CONNECTOR"
    me

module.exports.makeConnector = makeConnector
module.exports.adder = adder
module.exports.informAboutValue = informAboutValue
module.exports.informAboutNoValue = informAboutNoValue
module.exports.hasValue = hasValue
module.exports.getValue = getValue
