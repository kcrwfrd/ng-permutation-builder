describe 'WidgetBuilderService:', ->
  WidgetBuilderService = null
  widgetStore = null

  beforeEach module 'app.widget'

  beforeEach inject (
    _WidgetBuilderService_
    _widgetStore_
  ) ->
    WidgetBuilderService = _WidgetBuilderService_
    widgetStore = _widgetStore_

  it 'Should be instantiated with the correct attributes.', ->
    expect(WidgetBuilderService.permutable_attributes).toEqual
      name: []
      description: []

  describe 'Build Permutations:', ->
    it 'Should only build valid permutations.', ->
      WidgetBuilderService.permutable_attributes =
        name: []
        description: ['foobar']

      WidgetBuilderService.buildPermutations()

      expect(WidgetBuilderService.permutations.length).toBe 0

  describe 'Create Permutations:', ->
    beforeEach ->
      WidgetBuilderService.permutable_attributes =
        name: ['foobar', 'whizbat']
        description: ['bing', 'bang']

      WidgetBuilderService.buildPermutations()

    it 'Should add permutations to the widget store.', ->
      spyOn widgetStore, 'addWidgets'

      WidgetBuilderService.createPermutations()

      expect(widgetStore.addWidgets).toHaveBeenCalled()
      expect(widgetStore.addWidgets.calls.mostRecent().args[0]).toEqual [
        name: 'foobar',
        description: 'bing'
      ,
        name: 'foobar'
        description: 'bang'
      ,
        name: 'whizbat',
        description: 'bing'
      ,
        name: 'whizbat'
        description: 'bang'
      ]

    it 'Should reset state.', ->
      WidgetBuilderService.createPermutations()

      expect(WidgetBuilderService.permutations).toEqual []
      expect(WidgetBuilderService.permutable_attributes).toEqual
        name: []
        description: []

    it 'Should return a promise.', ->
      promise = WidgetBuilderService.createPermutations()

      expect(typeof promise.then).toBe 'function'
