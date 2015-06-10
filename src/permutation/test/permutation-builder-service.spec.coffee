describe 'PermutationBuilderService:', ->
  PermutationBuilderService = null
  permutationBuilder = null

  beforeEach module 'app.permutation'

  beforeEach inject (
    _PermutationBuilderService_
  ) ->
    PermutationBuilderService = _PermutationBuilderService_

    permutationBuilder = new PermutationBuilderService()

    # We'll fake some permutable attributes.
    # Normally, these would be defined by a subclass.
    permutationBuilder.permutable_attributes =
      name: []
      url: []

  describe 'Adding an Attribute:', ->
    it 'Should correctly add a unique value.', ->
      was_added = permutationBuilder.addAttribute 'name', 'foobar'

      expect(was_added).toBe true
      expect(permutationBuilder.permutable_attributes.name).toEqual [
        'foobar'
      ]

    it 'Should not add the same value twice.', ->
      spyOn console, 'warn'

      permutationBuilder.addAttribute 'name', 'foobar'
      was_added = permutationBuilder.addAttribute 'name', 'foobar'

      expect(permutationBuilder.permutable_attributes.name).toEqual [
        'foobar'
      ]
      expect(was_added).toBe false
      expect(console.warn).toHaveBeenCalled()

    it 'Should build permutations after successfully adding an attribute.', ->
      spyOn(permutationBuilder, 'buildPermutations').and.callThrough()

      permutationBuilder.addAttribute 'name', 'foobar'

      expect(permutationBuilder.buildPermutations).toHaveBeenCalled()
      expect(permutationBuilder.permutations).toEqual [
        name: 'foobar'
      ]

    it 'Should throw an error if attribute key does not exist.', ->
      expect(
        -> permutationBuilder.addAttribute 'foo', 'bar'
      ).toThrow Error "Invalid key: 'foo'"

  describe 'Removing an Attribute:', ->
    beforeEach ->
      permutationBuilder.addAttribute 'name', 'foo'
      permutationBuilder.addAttribute 'name', 'bar'

    it 'Should correctly remove an attribute.', ->
      was_removed = permutationBuilder.removeAttribute 'name', 0

      expect(was_removed).toBe true
      expect(permutationBuilder.permutable_attributes).toEqual
        name: ['bar']
        url: []

    it 'Should build permutations after successfully removing an attribute.', ->
      spyOn(permutationBuilder, 'buildPermutations').and.callThrough()

      permutationBuilder.removeAttribute 'name', 1

      expect(permutationBuilder.buildPermutations).toHaveBeenCalled()
      expect(permutationBuilder.permutations).toEqual [
        name: 'foo'
      ]

    it 'Should throw an error if attribute key does not exist.', ->
      expect(
        -> permutationBuilder.removeAttribute 'foo', 1
      ).toThrow Error "Invalid key: 'foo'"

  describe 'Building Permutations:', ->
    beforeEach ->
      permutationBuilder.addAttribute 'name', 'foo'
      permutationBuilder.addAttribute 'name', 'bar'

    it 'Should clear out previously built permutations.', ->
      expect(permutationBuilder.permutations.length).toBe 2

      permutationBuilder.addAttribute 'name', 'wat'

      # Only 3 total, rather than the original 2 plus 3 new ones
      expect(permutationBuilder.permutations.length).toBe 3

    it 'Should apply global attributes to all permutations.', ->
      permutationBuilder.attributes =
        whiz: 'bang'

      permutationBuilder.buildPermutations()

      expect(permutationBuilder.permutations).toEqual [
        name: 'foo'
        whiz: 'bang'
      ,
        name: 'bar'
        whiz: 'bang'
      ]
