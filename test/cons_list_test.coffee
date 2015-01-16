cons = require('../src/cons_list').cons
car = require('../src/cons_list').car
cdr = require('../src/cons_list').cdr
cadr = require('../src/cons_list').cadr
cddr = require('../src/cons_list').cddr
setCar = require('../src/cons_list').setCar
setCdr = require('../src/cons_list').setCdr
memq = require('../src/cons_list').memq
forEachExcept = require('../src/cons_list').forEachExcept

assert = require 'power-assert'

describe 'Verify primitive procedure', ->
  it 'should return dispatch', ->
    assert.ok cons 1, 3
  it 'should return 1', ->
    target = cons 1, 3
    assert (car target) is 1
  it 'should return 3', ->
    target = cons 1, 3
    assert (cdr target) is 3
  it 'should return 5', ->
    target = cons 1, 3
    setCar target, 5
    assert (car target) is 5
  it 'should return 7', ->
    target = cons 1, 3
    setCdr target, 7
    assert (cdr target) is 7

describe 'Verify compound object', ->
  it 'should return 2 and 1', ->
    target = (cons 3,(cons 2,(cons 1,null)))
    assert (cadr target) is 2
    assert (car (cddr target)) is 1

describe 'Verify compound procedures', ->
  describe 'memq', ->
    target = (cons 3,(cons 2,(cons 1,null)))
    it 'should return 1', ->
      assert (car (memq 1, target)) is 1
    it 'should return false', ->
      assert (memq 4, target) is false
  describe 'forEachExcept', ->
    a = (cons 3, null)
    b = (cons 2, null)
    c = (cons 1, null)
    target = (cons a, (cons b, (cons c, null)))
    it 'should return ((3) (5) (4))', ->
      f = (x) -> (setCar x, ((car x) + 3))
      forEachExcept a, f, target
      assert (car (car target)) is 3
      assert (car (car (cdr target))) is 5
      assert (car (car (cddr target))) is 4
