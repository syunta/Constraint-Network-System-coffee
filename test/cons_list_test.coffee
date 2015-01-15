_ = require '../src/cons_list'
assert = require 'power-assert'

describe 'Verify primitive procedure', ->
  it 'should return dispatch', ->
    assert.ok _.cons 1, 3
  it 'should return 1', ->
    target = _.cons 1, 3
    assert _.car(target) is 1
  it 'should return 3', ->
    target = _.cons 1, 3
    assert _.cdr(target) is 3
  it 'should return 5', ->
    target = _.cons 1, 3
    _.setCar target, 5
    assert _.car(target) is 5
  it 'should return 7', ->
    target = _.cons 1, 3
    _.setCdr target, 7
    assert _.cdr(target) is 7

describe 'Verify compound object', ->
  it 'should return 2 and 1', ->
    target = (_.cons 3,(_.cons 2,(_.cons 1,null)))
    assert (_.cadr target) is 2
    assert (_.car (_.cddr target)) is 1

describe 'Verify compound procedures', ->
  describe 'memq', ->
    target = (_.cons 3,(_.cons 2,(_.cons 1,null)))
    it 'should return 1', ->
      assert (_.car (_.memq 1, target)) is 1
    it 'should return false', ->
      assert (_.memq 4, target) is false
  describe 'forEachExcept', ->
    a = (_.cons 3, null)
    b = (_.cons 2, null)
    c = (_.cons 1, null)
    target = (_.cons a, (_.cons b, (_.cons c, null)))
    it 'should return ((3) (5) (4))', ->
      f = (x) -> (_.setCar x, ((_.car x) + 3))
      _.forEachExcept a, f, target
      assert (_.car (_.car target)) is 3
      assert (_.car (_.car (_.cdr target))) is 5
      assert (_.car (_.car (_.cddr target))) is 4
