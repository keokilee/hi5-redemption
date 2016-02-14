import expect from 'expect'

import Location from 'src/models/Location'

const LOCATION = {
  attributes: {
    OBJECTID: 1,
    Island: 'HAWAII',
    County: 'HAWAII',
    Location: 'Hilo - Makaala',
    Site_Address: 'Atlas Recycling Recycling Facility (30 Makaala Street, Hilo)',
    Days_and_Hours_of_Operation: 'Mo-Fr 08:00-17:00; Sa,Su 08:00-15:00',
    Latest_Change__Orig___Date: null,
    Comments: 'Accepts large loads.',
    Address: '30 Makaala Street',
    City_1: 'Hilo',
    Zip: 96720,
    ns1_name4: 'Atlas Recycling Center',
    ns1_longitude: -155.067670510878,
    ns1_latitude: 19.7047862934356,
    CreationDate: 1437101499097,
    Status: 'OPEN'
  },
  geometry: {
    x: -155.06809091599973,
    y: 19.70477682200044
  }
}

describe('models/Location', () => {
  let location

  beforeEach(() => {
    location = new Location(LOCATION)
  })

  it('is an instance of Location', () => {
    expect(location).toBeA(Location)
  })

  describe('attributes', () => {
    it('has a id', () => {
      expect(location.id).toEqual(LOCATION.attributes.OBJECTID)
    })

    it('has an island', () => {
      expect(location.island).toEqual(LOCATION.attributes.Island)
    })

    it('has a name', () => {
      expect(location.name).toEqual(LOCATION.attributes.ns1_name4)
    })

    it('has an address', () => {
      expect(location.address).toEqual(LOCATION.attributes.Address)
    })

    it('has a site address', () => {
      expect(location.siteAddress).toEqual(LOCATION.attributes.Site_Address)
    })

    it('has a location', () => {
      expect(location.location).toEqual(LOCATION.attributes.Location)
    })

    it('has an island', () => {
      expect(location.island).toEqual(LOCATION.attributes.Island)
    })

    it('has a county', () => {
      expect(location.county).toEqual(LOCATION.attributes.County)
    })

    it('has hours', () => {
      expect(location.hours).toEqual(LOCATION.attributes.Days_and_Hours_of_Operation)
    })
  })

  describe('methods', () => {
    it('produces a link to Google Maps', () => {
      const { x, y } = LOCATION.geometry

      expect(location.mapsLink()).toContain(x)
      expect(location.mapsLink()).toContain(y)
    })

    describe('formattedHours', () => {
      // Hours are 'Mo-Fr 08:00-17:00; Sa,Su 08:00-15:00',
      it('has fully formatted hours', () => {
        expect(location.formattedHours()).toEqual(
          'Monday - Friday from 8:00 AM - 5:00 PM\nSaturday, Sunday from 8:00 AM - 3:00 PM'
        )
      })
    })
  })
})
