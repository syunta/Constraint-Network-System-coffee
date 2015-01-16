cons = require('../src/cons_list').cons
car = require('../src/cons_list').car
cdr = require('../src/cons_list').cdr
cadr = require('../src/cons_list').cadr
cddr = require('../src/cons_list').cddr
setCar = require('../src/cons_list').setCar
setCdr = require('../src/cons_list').setCdr

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
