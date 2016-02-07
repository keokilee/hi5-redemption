import expect from 'expect'
import moment from 'moment'

import TimeParser from 'src/services/time_parser'

describe('services/time_parser', () => {
  const parser = new TimeParser()

  describe('#openToday', () => {
    describe('ranged dates', () => {
      describe('normal range', () => {
        const DATE_STRING = 'Mo-Sa 08:00-17:00'

        it('is open at the beginning of the range', () => {
          const date = moment().day(1).toDate()
          expect(parser.openToday(DATE_STRING, date)).toBe(true)
        })

        it('is open in the middle of the range', () => {
          const date = moment().day(3).toDate()
          expect(parser.openToday(DATE_STRING, date)).toBe(true)
        })

        it('is open at the end of the range', () => {
          const date = moment().day(6).toDate()
          expect(parser.openToday(DATE_STRING, date)).toBe(true)
        })

        it('is not open if the day is not specified', () => {
          const date = moment().day(0).toDate()
          expect(parser.openToday(DATE_STRING, date)).toBe(false)
        })
      })

      describe('ranges that end on Sunday', () => {
        const DATE_STRING = 'We-Su 08:00-17:00'

        it('is open at the beginning of the range', () => {
          const date = moment().day(3).toDate()
          expect(parser.openToday(DATE_STRING, date)).toBe(true)
        })

        it('is open in the middle of the range', () => {
          const date = moment().day(4).toDate()
          expect(parser.openToday(DATE_STRING, date)).toBe(true)
        })

        it('is open at the end of the range', () => {
          const date = moment().day(0).toDate()
          expect(parser.openToday(DATE_STRING, date)).toBe(true)
        })
      })
    })

    describe('comma-delimited days', () => {
      const DATE_STRING = 'We,Fr,Sa,Su 08:00-15:30'

      it('is open for one of the specified days', () => {
        const date = moment().day(6).toDate()
        expect(parser.openToday(DATE_STRING, date)).toBe(true)
      })

      it('is closed for one of the unspecified day', () => {
        const date = moment().day(1).toDate()
        expect(parser.openToday(DATE_STRING, date)).toBe(false)
      })
    })
  })
})
