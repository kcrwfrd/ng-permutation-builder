describe 'widgetFactory:', ->
  permutationFactory = null
  widgetFactory = null

  beforeEach module 'app.widget'

  beforeEach inject (
    _permutationFactory_
    _widgetFactory_
  ) ->
    permutationFactory = _permutationFactory_
    widgetFactory = _widgetFactory_

  describe 'buildPermutations:', ->
    widgets = null
    permutable_attributes = null

    beforeEach ->
      spyOn(permutationFactory, 'permute').and.callThrough()

      permutable_attributes =
        name: ['foo', 'bar']
        desc: ['biz', 'bat']

      widgets = widgetFactory.buildPermutations permutable_attributes

    it 'Should call permutationFactory.permute with the correct arguments to generate permutations.', ->
      # Permutable attributes are first arg
      expect(
        permutationFactory.permute.calls.mostRecent().args[0]
      ).toEqual permutable_attributes

      # Callback handler is second arg
      expect(
        typeof permutationFactory.permute.calls.mostRecent().args[1]
      ).toBe 'function'

    it 'Should return 4 widgets with correct attributes.', ->
      expect(widgets).toEqual [
        name: 'foo'
        desc: 'biz'
      ,
        name: 'foo'
        desc: 'bat'
      ,
        name: 'bar'
        desc: 'biz'
      ,
        name: 'bar'
        desc: 'bat'
      ]
