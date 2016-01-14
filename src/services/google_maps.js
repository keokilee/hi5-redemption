/* global __MAPS_KEY__:false */
import MapsLoader from 'google-maps'

MapsLoader.KEY = __MAPS_KEY__
MapsLoader.LIBRARIES = ['places']

export default MapsLoader
