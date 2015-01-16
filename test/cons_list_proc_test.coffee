cons = require('../src/cons_list').cons
car = require('../src/cons_list').car
cdr = require('../src/cons_list').cdr
cadr = require('../src/cons_list').cadr
cddr = require('../src/cons_list').cddr
setCar = require('../src/cons_list').setCar
setCdr = require('../src/cons_list').setCdr
memq = require('../src/cons_list_proc').memq
forEachExcept = require('../src/cons_list_proc').forEachExcept

assert = require 'power-assert'

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
