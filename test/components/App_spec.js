import expect, { spyOn } from 'expect'

import App from 'src/App'
import Location from 'src/models/Location'

describe('App', () => {
  describe('#ready', () => {
    it('loads locations', () => {
      const loadStub = spyOn(Location, 'load').andReturn([])
      App.ready()
      expect(loadStub).toHaveBeenCalled()
    })

    it('sends the locations to the store', (done) => {
      const promise = new Promise((resolve) => resolve([]))
      spyOn(Location, 'load').andReturn(promise)

      App.initRecyclingCenters = () => {}
      const actionSpy = spyOn(App, 'initRecyclingCenters')
      App.ready()
      promise.then((arg) => {
        expect(actionSpy).toHaveBeenCalledWith([])
        done()
      })
    })
  })
})
