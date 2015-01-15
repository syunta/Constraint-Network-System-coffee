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
