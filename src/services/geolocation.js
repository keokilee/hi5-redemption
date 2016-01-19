export function getLocation () {
  return new Promise((resolve, reject) => {
    if (!navigator.geolocation) {
      reject('Geolocation not supported')
    }

    navigator.geolocation.getCurrentPosition(position => {
      resolve([position.coords.latitude, position.coords.longitude])
    }, () => {
      reject('Error fetching location')
    })
  })
}

export function run (generator) {
  const it = generator(go)

  function go (result) {
    if (result.done) {
      return it.next(result.value)
    }

    return result.value.then(value => {
      return go(it.next(value))
    }, err => {
      return go(it.throw(err))
    })
  }

  go(it.next())
}
