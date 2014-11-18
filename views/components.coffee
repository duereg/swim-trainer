# home = require('./home.cjsx')

#workouts
processWorkout = require('./workouts/processWorkout.cjsx')
simpleWorkout = require('./workouts/simpleWorkout.cjsx')
# list = require('./workouts/list.cjsx')

#account
# login = require('./account/login.cjsx')
# profile = require('./account/profile.cjsx')

module.exports = [simpleWorkout, processWorkout] #[home, add, list, login, profile]
