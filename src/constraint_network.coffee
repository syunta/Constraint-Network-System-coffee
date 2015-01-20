cons = require('./cons_list').cons
car = require('./cons_list').car
cdr = require('./cons_list').cdr
setCar = require('./cons_list').setCar
setCdr = require('./cons_list').setCdr
memq = require('./cons_list_proc').memq
forEachExcept = require('./cons_list_proc').forEachExcept

informAboutValue = (constraint) ->
  constraint 'I-have-a-value'

informAboutNoValue = (constraint) ->
  constraint 'I-lost-my-value'

hasValue = (connector) ->
  connector 'has-value?'

getValue = (connector) ->
  connector 'value'

setValue = (connector, newValue, informant) ->
  ((connector 'set-value!') newValue, informant)

forgetValue = (connector, retractor) ->
  ((connector 'forget') retractor)

connect = (connector, newConstraint) ->
  ((connector 'connect') newConstraint)

adder = (a1, a2, sum) ->
  processNewValue = ->
    if (hasValue a1) and (hasValue a2)
      setValue sum,
               (getValue a1) + (getValue a2),
               me
    else if (hasValue a1) and (hasValue sum)
      setValue a2,
               (getValue sum) - (getValue a1),
               me
    else if (hasValue a2) and (hasValue sum)
      setValue a1,
               (getValue sum) - (getValue a2),
               me
  processForgetValue = ->
    forgetValue sum, me
    forgetValue a1, me
    forgetValue a2, me
    do processNewValue
  me = (request) ->
    switch request
      when 'I-have-a-value'  then do processNewValue
      when 'I-lost-my-value' then do processForgetValue
      else throw new Error "Unknown request -- ADDER #{request}"
  (connect a1, me)
  (connect a2, me)
  (connect sum, me)
  me

constant = (value, connector) ->
  me = (request) ->
    throw new Error "Unknown request -- CONSTANT #{request}"
  (connect connector, me)
  (setValue connector, value, me)
  me

multiplier = (m1, m2, product) ->
  processNewValue = ->
    if ((hasValue m1) and ((getValue m1) is 0)) or
       ((hasValue m2) and ((getValue m2) is 0))
      setValue product, 0, me
    else if (hasValue m1) and (hasValue m2)
      setValue product,
               (getValue m1) * (getValue m2),
               me
    else if (hasValue product) and (hasValue m1)
      setValue m2,
               (getValue product) / (getValue m1),
               me
    else if (hasValue product) and (hasValue m2)
      setValue m1,
               (getValue product) / (getValue m2),
               me

  processForgetValue = ->
    (forgetValue product, me)
    (forgetValue m1, me)
    (forgetValue m2, me)
    do processNewValue

  me = (request) ->
    switch request
      when 'I-have-a-value'  then do processNewValue
      when 'I-lost-my-value' then do processForgetValue
      else throw new Error "Unknown request -- MULTIPLIER #{request}"
  (connect m1, me)
  (connect m2, me)
  (connect product, me)
  me


makeConnector = ->
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
        'ignored'

    forgetMyValue = (retractor) ->
      if retractor is informant
        informant = false
        forEachExcept retractor,
                      informAboutNoValue,
                      constraints
      else
        'ignored'

    connectMe = (newConstraint) ->
      if not (memq newConstraint, constraints)
        constraints = (cons newConstraint, constraints)
      if (hasValue me)
        informAboutValue newConstraint
      'done'

    me = (request) ->
      switch request
        when 'has-value?'
          if informant then true else false
        when 'value'       then value
        when 'constraints' then constraints # open for test code
        when 'set-value!'  then setMyValue
        when 'forget'      then forgetMyValue
        when 'connect'     then connectMe
        else throw new Error "Unknown operation -- CONNECTOR #{request}"
    me

module.exports.makeConnector = makeConnector
module.exports.adder = adder
module.exports.constant = constant
module.exports.multiplier = multiplier
module.exports.informAboutValue = informAboutValue
module.exports.informAboutNoValue = informAboutNoValue
module.exports.hasValue = hasValue
module.exports.getValue = getValue
module.exports.setValue = setValue
module.exports.forgetValue = forgetValue
module.exports.connect = connect
