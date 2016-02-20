import expect from 'expect'

import LocationRow from 'src/components/LocationRow'

describe('components/LocationRow', () => {
  it('takes a location as props', () => {
    expect(LocationRow.props.location).toEqual(null)
  })

  it('takes coordinates as props', () => {
    expect(LocationRow.props.coordinates).toEqual(null)
  })

  describe('#distanceLabel', () => {
    it('returns empty if there are no coordinates', () => {
      expect(LocationRow.methods.distanceLabel()).toEqual('')
    })
  })
})
