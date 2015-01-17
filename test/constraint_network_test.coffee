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

assert = require 'power-assert'

describe 'Verify connector', ->
  describe 'when request is value', ->
    it 'should return false', ->
      c = do _.makeConnector
      assert (c "value") is false
