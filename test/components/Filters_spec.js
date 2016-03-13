import expect, { spyOn } from 'expect'

import Filters from 'src/components/Filters'

describe('components/Filters', () => {
  describe('#methods', () => {
    it('sends the setOpen action when #openChange is called', () => {
      Filters.methods.setOpen = () => {}
      const actionSpy = spyOn(Filters.methods, 'setOpen')
      Filters.methods.openChange()

      expect(actionSpy).toHaveBeenCalled()
    })

    it('sends the setDistance action when #distanceChange is called', () => {
      Filters.methods.setDistance = () => {}
      const actionSpy = spyOn(Filters.methods, 'setDistance')
      Filters.methods.distanceChange()

      expect(actionSpy).toHaveBeenCalled()
    })
  })
})
