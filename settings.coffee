###
Do not edit. Settings are loaded from config directory.
###
settings = require 'nconf'

# First consider commandline arguments and environment variables, respectively.
settings.argv().env()

# Set environment to development if it is not set.
settings.set 'NODE_ENV', 'development'

# Then load the environment's settings.
settings.file { file: 'settings/#{settings.get("NODE_ENV")}.json' }

# Provide default values for settings not provided above.
settings.defaults
    'PORT': 3000

exports.config = settings