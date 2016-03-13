export function getLocation () {
  return new Promise((resolve, reject) => {
    if (!navigator.geolocation) {
      reject('Geolocation not supported')
    }

    navigator.geolocation.getCurrentPosition((position) => {
      resolve([position.coords.latitude, position.coords.longitude])
    }, () => {
      reject('Error fetching location')
    })
  })
}
