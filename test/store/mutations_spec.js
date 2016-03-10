import expect from 'expect'

import {
  SET_LOCATION,
  SET_OPEN,
  SET_DISTANCE,
  SET_CENTER,
  INIT_RECYCLING_CENTERS
} from 'src/store/actions'

import mutations from 'src/store/mutations'

const DEFAULT_STATE = {
  allCenters: [],
  recyclingCenters: [],
  coordinates: { latitude: 0, longitude: 0, name: 'Test' }
}

describe('store/mutations', () => {
  describe('SET_CENTER', () => {
    it('sets the center id', () => {
      const state = { ...DEFAULT_STATE }
      mutations[SET_CENTER](state, 'foo')
      expect(state.selectedCenter).toEqual('foo')
    })
  })

  describe('SET_OPEN', () => {
    it('sets the state filter', () => {
      const state = { ...DEFAULT_STATE, filters: {} }
      mutations[SET_OPEN](state, true)
      expect(state.filters.open).toBe(true)
    })
  })
})
