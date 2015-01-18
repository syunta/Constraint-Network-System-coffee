doNothing = (connector) ->
  processNewValue = () ->
  processForgetValue = () ->
  me = (request) ->
    switch request
      when 'I-have-a-value'  then do processNewValue
      when 'I-lost-my-value' then do processForgetValue
      else throw new Error "Unknown request -- ADDER #{request}"
  me

module.exports.doNothing = doNothing
