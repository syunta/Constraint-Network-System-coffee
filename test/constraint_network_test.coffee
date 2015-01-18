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
_.doNothing = require('./do_nothing_constraint').doNothing
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
      n = _.doNothing 'c'
      assert (informAboutValue n) is (n 'I-have-a-value')
  describe 'informAboutNoValue', ->
    it 'should be equal', ->
      n = _.doNothing 'c'
      assert (informAboutNoValue n) is (n 'I-lost-my-value')

  describe 'hasValue', ->
    c = do _.makeConnector
    it 'should be equal', ->
      assert (hasValue c) is (c 'has-value?')
  describe 'getValue', ->
    c = do _.makeConnector
    it 'should be equal', ->
      assert (getValue c) is (c 'value')
  describe 'setValue', ->
    it 'should return 1', ->
      c = do _.makeConnector
      (setValue c, 1, 'tester')
      assert (c 'value') is 1
  describe 'forgetValue', ->
    it 'should return false', ->
      c = do _.makeConnector
      (setValue c, 1, 'tester')
      (forgetValue c, 'tester')
      assert (c 'has-value?') is false
    it 'should return true', ->
      c = do _.makeConnector
      (setValue c, 1, 'tester')
      (forgetValue c, 'not tester')
      assert (c 'has-value?') is true
  describe 'connect', ->
    it 'should be equal', ->
      c = do _.makeConnector
      d = _.doNothing c
      (connect c, d)
      assert (car (c 'constraints')) is d

describe 'Verify connector', ->
  describe 'when request is has-value?', ->
    it 'should return false', ->
      c = do _.makeConnector
      assert (c 'has-value?') is false
  describe 'when request is value', ->
    it 'should return false', ->
      c = do _.makeConnector
      assert (c 'value') is false
  describe 'when request is set-value!', ->
    c = do _.makeConnector
    ((c 'set-value!') 1, 'tester')
    it 'should return 1', ->
      assert (c 'value') is 1
    it 'should has value and informant', ->
      assert (c 'has-value?') is true
    it 'should be ignored', ->
      assert ((c 'set-value!') 1, 'tester') is 'ignored'
  describe 'when request is forget', ->
    c = do _.makeConnector
    it 'should be ignored', ->
      assert ((c 'forget') 'tester') is 'ignored'
    it 'should return false', ->
      ((c 'set-value!') 1, 'tester')
      ((c 'forget') 'tester')
      assert (c 'has-value?') is false
  describe 'when request is connect', ->
    it 'should add constraint', ->
      c = do _.makeConnector
      target1 = _.doNothing c
      target2 = _.doNothing c
      ((c 'connect') target1)
      ((c 'connect') target2)
      assert (car (c 'constraints')) is target2
      assert (cadr (c 'constraints')) is target1
