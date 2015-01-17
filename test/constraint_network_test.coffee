cons = require('../src/cons_list').cons
car = require('../src/cons_list').car
cdr = require('../src/cons_list').cdr
cadr = require('../src/cons_list').cadr
cddr = require('../src/cons_list').cddr
setCar = require('../src/cons_list').setCar
setCdr = require('../src/cons_list').setCdr
memq = require('../src/cons_list_proc').memq
forEachExcept = require('../src/cons_list_proc').forEachExcept

_ = require '../src/constraint_network'
informAboutValue = require('../src/constraint_network').informAboutValue
informAboutNoValue = require('../src/constraint_network').informAboutNoValue

assert = require 'power-assert'

dummy = "" # debuging code

describe 'Verify syntax interface', ->
  describe 'informAboutValue', ->
    it 'should be equal', ->
      target = _.adder dummy,dummy,dummy
      assert (informAboutValue target) is (target "I-have-a-value")
  describe 'informAboutNoValue', ->
    it 'should be equal', ->
      target = _.adder dummy,dummy,dummy
      assert (informAboutNoValue target) is (target "I-lost-my-value")

describe 'Verify connector', ->
  describe 'when request is value', ->
    it 'should return false', ->
      c = do _.makeConnector
      assert (c "value") is false
