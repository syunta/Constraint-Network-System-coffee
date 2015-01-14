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
