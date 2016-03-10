import expect, { spyOn } from 'expect'

import App from 'src/App'
import Location from 'src/models/Location'

import store from 'src/store'

describe('App', () => {
  describe('#ready', () => {
    it('loads locations', () => {
      const loadStub = spyOn(Location, 'load').andReturn([])
      App.ready()
      expect(loadStub).toHaveBeenCalled()
    })

    it('sends the locations to the store', (done) => {
      const promise = new Promise(resolve => resolve([]))
      spyOn(Location, 'load').andReturn(promise)
      const actionSpy = spyOn(store.actions, 'initRecyclingCenters')

      App.ready()
      promise.then(arg => {
        expect(actionSpy).toHaveBeenCalledWith([])
        done()
      })
    })
  })
})
