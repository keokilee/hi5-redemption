/* global describe:false, it: false */
import expect from 'expect'

import Vue from 'vue'
import Header from 'src/components/Header'

describe('Header', () => {
  function renderTemplate (template) {
    return new Vue({
      template,
      components: {
        'app-header': Header
      }
    }).$mount()
  }

  it('displays a title', () => {
    const title = 'Test Title'
    const vm = renderTemplate(`<div><app-header title="${title}"></app-header></div>`)

    expect(vm.$el.querySelector('h2').textContent.trim()).toEqual(title)
  })
})
