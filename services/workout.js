var Workout = require('../models/Workout');

module.exports = {
  getWorkoutsByUserId: function(userId) {
    return Workout.promise.find({'userId': userId});
  },
  getWorkoutById: function(id, userId) {
    return Workout.promise.findOne({_id: id, userId: userId});
  },
  getRecentWorkouts: function() {
    return Workout.find().sort('date').limit(10).lean().promise.exec();
  }
};
