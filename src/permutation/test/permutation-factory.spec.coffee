describe 'permutationFactory:', ->
  permutationFactory = null

  beforeEach module 'app.permutation'

  beforeEach inject (
    _permutationFactory_
  ) ->
    permutationFactory = _permutationFactory_

  describe 'permute:', ->
    expected_result = [
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

    it 'Should generate 4 permutations from 2 properties with 2 values each.', ->
      permutable_attributes =
        name: ['foo', 'bar']
        attr: ['biz', 'bat']

      permutations = permutationFactory.permute permutable_attributes

      expect(permutations).toEqual expected_result

    it 'Should ignore attributes without any values.', ->
      permutable_attributes =
        name: ['foo', 'bar']
        empty: []
        attr: ['biz', 'bat']

      permutations = permutationFactory.permute permutable_attributes

      expect(permutations).toEqual expected_result

    it 'Should ignore empty attributes at the end of the object.', ->
      permutable_attributes =
        name: ['foo', 'bar']
        attr: ['biz', 'bat']
        empty: []

      permutations = permutationFactory.permute permutable_attributes

      expect(permutations).toEqual expected_result

    it 'Should invoke an optional callback for each permutation', ->
      callback = jasmine.createSpy 'callback'

      permutable_attributes =
        name: ['foo', 'bar']
        attr: ['biz', 'bat']

      permutations = permutationFactory.permute permutable_attributes, callback

      expect(callback.calls.count()).toBe 4

      for i in [0..3]
        expect(callback.calls.argsFor(i)).toEqual [expected_result[i]]
