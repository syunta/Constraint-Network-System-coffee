celsiusFahrenheitConverter = require('../src/celsius_fahrenheit_converter').celsiusFahrenheitConverter
makeConnector = require('../src/constraint_network').makeConnector
probe = require('../src/constraint_network').probe
setValue = require('../src/constraint_network').setValue
getValue = require('../src/constraint_network').getValue
forgetValue = require('../src/constraint_network').forgetValue

assert = require 'power-assert'

describe 'Verify celsiusFahrenheitConverter', ->
  it 'should return Fahrenheit temp = 77', ->
    c = do makeConnector
    f = do makeConnector
    celsiusFahrenheitConverter c, f
    probe 'Celsius temp', c
    probe 'Fahrenheit temp', f
    setValue c, 25, 'tester'
    assert (getValue f) is 77
  it 'should return Celsius temp = 100', ->
    c = do makeConnector
    f = do makeConnector
    celsiusFahrenheitConverter c, f
    probe 'Celsius temp', c
    probe 'Fahrenheit temp', f
    setValue c, 25, 'tester'
    forgetValue c, 'tester'
    setValue f, 212, 'tester'
    assert (getValue c) is 100
