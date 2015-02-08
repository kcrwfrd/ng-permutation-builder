describe 'permutationFactory:', ->
  permutationFactory = null

  beforeEach module 'app.permutation'

  beforeEach inject (
    _permutationFactory_
  ) ->
    permutationFactory = _permutationFactory_

  describe 'permute:', ->
    # Expected result for 2*2
    result_2x2 = [
      name: 'foo'
      attr: 'biz'
    ,
      name: 'foo'
      attr: 'bat'
    ,
      name: 'bar'
      attr: 'biz'
    ,
      name: 'bar'
      attr: 'bat'
    ]

    it 'Should generate 4 permutations from 2*2 attributes.', ->
      permutable_attributes =
        name: ['foo', 'bar']
        attr: ['biz', 'bat']

      permutations = permutationFactory.permute permutable_attributes

      expect(permutations).toEqual result_2x2

    it 'Should generate 6 permutations from 2*1*0*3 attributes.', ->
      permutable_attributes =
        name: ['foo', 'bar']
        type: ['biz']
        empty: []
        desc: ['bing', 'bang', 'boom']

      permutations = permutationFactory.permute permutable_attributes

      expect(permutations).toEqual [
        name: 'foo'
        type: 'biz'
        desc: 'bing'
      ,
        name: 'foo'
        type: 'biz'
        desc: 'bang'
      ,
        name: 'foo'
        type: 'biz'
        desc: 'boom'
      ,
        name: 'bar'
        type: 'biz'
        desc: 'bing'
      ,
        name: 'bar'
        type: 'biz'
        desc: 'bang'
      ,
        name: 'bar'
        type: 'biz'
        desc: 'boom'
      ]

    it 'Should ignore attributes without any values.', ->
      permutable_attributes =
        name: ['foo', 'bar']
        empty: []
        attr: ['biz', 'bat']

      permutations = permutationFactory.permute permutable_attributes

      expect(permutations).toEqual result_2x2

    it 'Should ignore empty attributes at the end of the object.', ->
      permutable_attributes =
        name: ['foo', 'bar']
        attr: ['biz', 'bat']
        empty: []

      permutations = permutationFactory.permute permutable_attributes

      expect(permutations).toEqual result_2x2

    it 'Should invoke an optional callback for each permutation', ->
      callback = jasmine.createSpy 'callback'

      permutable_attributes =
        name: ['foo', 'bar']
        attr: ['biz', 'bat']

      permutations = permutationFactory.permute permutable_attributes, callback

      expect(callback.calls.count()).toBe 4

      for i in [0..3]
        expect(callback.calls.argsFor(i)).toEqual [result_2x2[i]]
