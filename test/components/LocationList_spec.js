import expect from 'expect'

import LocationList from 'src/components/LocationList'

describe('components/LocationList', () => {
  it('takes a list of locations as props', () => {
    expect(LocationList.props.locations).toEqual(null)
  })

  it('takes coordinates as props', () => {
    expect(LocationList.props.coordinates).toEqual(null)
  })
})
