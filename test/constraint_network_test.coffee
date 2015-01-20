cons = require('../src/cons_list').cons
car = require('../src/cons_list').car
cdr = require('../src/cons_list').cdr
cadr = require('../src/cons_list').cadr
cddr = require('../src/cons_list').cddr
setCar = require('../src/cons_list').setCar
setCdr = require('../src/cons_list').setCdr
memq = require('../src/cons_list_proc').memq
forEachExcept = require('../src/cons_list_proc').forEachExcept

makeConnector = require('../src/constraint_network').makeConnector
adder = require('../src/constraint_network').adder
constant = require('../src/constraint_network').constant
multiplier = require('../src/constraint_network').multiplier
doNothing = require('./do_nothing_constraint').doNothing
informAboutValue = require('../src/constraint_network').informAboutValue
informAboutNoValue = require('../src/constraint_network').informAboutNoValue
hasValue = require('../src/constraint_network').hasValue
getValue = require('../src/constraint_network').getValue
setValue = require('../src/constraint_network').setValue
forgetValue = require('../src/constraint_network').forgetValue
connect = require('../src/constraint_network').connect

assert = require 'power-assert'

describe 'Verify syntax interface', ->
  describe 'informAboutValue', ->
    it 'should be equal', ->
      n = doNothing 'c'
      assert (informAboutValue n) is (n 'I-have-a-value')
  describe 'informAboutNoValue', ->
    it 'should be equal', ->
      n = doNothing 'c'
      assert (informAboutNoValue n) is (n 'I-lost-my-value')

  describe 'hasValue', ->
    c = do makeConnector
    it 'should be equal', ->
      assert (hasValue c) is (c 'has-value?')
  describe 'getValue', ->
    c = do makeConnector
    it 'should be equal', ->
      assert (getValue c) is (c 'value')
  describe 'setValue', ->
    it 'should return 1', ->
      c = do makeConnector
      (setValue c, 1, 'tester')
      assert (c 'value') is 1
  describe 'forgetValue', ->
    it 'should return false', ->
      c = do makeConnector
      (setValue c, 1, 'tester')
      (forgetValue c, 'tester')
      assert (c 'has-value?') is false
    it 'should return true', ->
      c = do makeConnector
      (setValue c, 1, 'tester')
      (forgetValue c, 'not tester')
      assert (c 'has-value?') is true
  describe 'connect', ->
    it 'should be equal', ->
      c = do makeConnector
      d1 = doNothing c
      d2 = doNothing c
      (connect c, d1)
      (connect c, d2)
      assert (car (c 'constraints')) is d2
      assert (cadr (c 'constraints')) is d1

describe 'Verify connector', ->
  describe 'when request is has-value?', ->
    it 'should return false', ->
      c = do makeConnector
      assert (c 'has-value?') is false
  describe 'when request is value', ->
    it 'should return false', ->
      c = do makeConnector
      assert (c 'value') is false
  describe 'when request is set-value!', ->
    c = do makeConnector
    ((c 'set-value!') 1, 'tester')
    it 'should return 1', ->
      assert (c 'value') is 1
    it 'should has value and informant', ->
      assert (c 'has-value?') is true
    it 'should be ignored', ->
      assert ((c 'set-value!') 1, 'tester') is 'ignored'
  describe 'when request is forget', ->
    c = do makeConnector
    it 'should be ignored', ->
      assert ((c 'forget') 'tester') is 'ignored'
    it 'should return false', ->
      ((c 'set-value!') 1, 'tester')
      ((c 'forget') 'tester')
      assert (c 'has-value?') is false
  describe 'when request is connect', ->
    it 'should add constraint', ->
      c = do makeConnector
      target1 = doNothing c
      target2 = doNothing c
      ((c 'connect') target1)
      ((c 'connect') target2)
      assert (car (c 'constraints')) is target2
      assert (cadr (c 'constraints')) is target1

describe 'Verify adder is constaraint', ->
  describe 'when request is I-have-a-value', ->
    it 'should set sum 5 as a result of c1 + c2', ->
      c1 = do makeConnector
      c2 = do makeConnector
      sum = do makeConnector
      adder c1, c2, sum
      setValue c1, 1, 'tester'
      setValue c2, 4, 'tester'
      assert (getValue sum) is 5
    it 'should set c1 1 as a result of sum - c2', ->
      c1 = do makeConnector
      c2 = do makeConnector
      sum = do makeConnector
      adder c1, c2, sum
      setValue sum, 5, 'tester'
      setValue c2, 4, 'tester'
      assert (getValue c1) is 1
    it 'should set c2 1 as a result of sum - c1', ->
      c1 = do makeConnector
      c2 = do makeConnector
      sum = do makeConnector
      adder c1, c2, sum
      setValue sum, 5, 'tester'
      setValue c1, 1, 'tester'
      assert (getValue c2) is 4
  describe 'when request is I-lost-my-value', ->
    it 'should set value false', ->
      c1 = do makeConnector
      c2 = do makeConnector
      sum = do makeConnector
      adder c1, c2, sum
      setValue c1, 1, 'tester'
      setValue c2, 4, 'tester'
      forgetValue c1, 'tester'
      forgetValue c2, 'tester'
      assert (hasValue c1) is false
      assert (hasValue c2) is false
      assert (hasValue sum) is false
    it 'should be same setter to forget value', ->
      c1 = do makeConnector
      c2 = do makeConnector
      sum = do makeConnector
      adder c1, c2, sum
      setValue c1, 1, 'tester'
      setValue c2, 4, 'tester'
      forgetValue c1, 'tester'
      assert (hasValue c1) is false
      assert (hasValue c2) is true

describe 'Verify constant is constaraint', ->
  it 'should return 10', ->
    c = do makeConnector
    constant 10, c
    assert (getValue c) is 10

describe 'Verify multiplier is constaraint', ->
  describe 'when request is I-have-a-value', ->
    it 'should set product 0 as a result of c1 * 0', ->
      c1 = do makeConnector
      c2 = do makeConnector
      product = do makeConnector
      multiplier c1, c2, product
      setValue c1, 2, 'tester'
      setValue c2, 0, 'tester'
      assert (getValue product) is 0
    it 'should set product 10 as a result of c1 * c2', ->
      c1 = do makeConnector
      c2 = do makeConnector
      product = do makeConnector
      multiplier c1, c2, product
      setValue c1, 2, 'tester'
      setValue c2, 5, 'tester'
      assert (getValue product) is 10
    it 'should set c2 5 as a result of product / c1', ->
      c1 = do makeConnector
      c2 = do makeConnector
      product = do makeConnector
      multiplier c1, c2, product
      setValue c1, 2, 'tester'
      setValue product, 10, 'tester'
      assert (getValue c2) is 5
    it 'should set c1 2 as a result of product / c2', ->
      c1 = do makeConnector
      c2 = do makeConnector
      product = do makeConnector
      multiplier c1, c2, product
      setValue c2, 5, 'tester'
      setValue product, 10, 'tester'
      assert (getValue c1) is 2
  describe 'when request is I-lost-my-value', ->
    it 'should set value false', ->
      c1 = do makeConnector
      c2 = do makeConnector
      product = do makeConnector
      multiplier c1, c2, product
      setValue c1, 2, 'tester'
      setValue c2, 5, 'tester'
      forgetValue c1, 'tester'
      forgetValue c2, 'tester'
      assert (hasValue c1) is false
      assert (hasValue c2) is false
      assert (hasValue product) is false
    it 'should be same setter to forget value', ->
      c1 = do makeConnector
      c2 = do makeConnector
      product = do makeConnector
      multiplier c1, c2, product
      setValue c1, 2, 'tester'
      setValue c2, 5, 'tester'
      forgetValue c1, 'tester'
      assert (hasValue c1) is false
      assert (hasValue c2) is true
