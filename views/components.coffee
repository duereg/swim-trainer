# home = require('./home.cjsx')

#workouts
processWorkout = require('./workouts/components/processWorkout.cjsx')
simpleWorkout = require('./workouts/components/simpleWorkout.cjsx')
list = require('./workouts/components/list.cjsx')

#account
# login = require('./account/login.cjsx')
# profile = require('./account/profile.cjsx')

module.exports = [simpleWorkout, processWorkout, list] #[home, add, list, login, profile]
