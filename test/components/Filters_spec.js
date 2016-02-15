import expect, { spyOn } from 'expect'

import Filters from 'src/components/Filters'
import store from 'src/store'

describe('components/Filters', () => {
  describe('#methods', () => {
    it('sends the setOpen action when #openChange is called', () => {
      const actionSpy = spyOn(store.actions, 'setOpen')
      Filters.methods.openChange()

      expect(actionSpy).toHaveBeenCalled()
    })

    it('sends the setDistance action when #distanceChange is called', () => {
      const actionSpy = spyOn(store.actions, 'setDistance')
      Filters.methods.distanceChange()

      expect(actionSpy).toHaveBeenCalled()
    })
  })
})
