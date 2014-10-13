home = require('./home.cjsx')

#workouts
add = require('./workouts/add.cjsx')
list = require('./workouts/list.cjsx')

#account
login = require('./account/login.cjsx')
profile = require('./account/profile.cjsx')

module.exports = [home, add, list, login, profile]
