var mongoose = require('mongoose');
var swimParser = require('swim-parser');

var workoutSchema = new mongoose.Schema({
  userId: mongoose.Schema.Types.ObjectId,
  date: {type: Date, default: Date.now },
  raw: String,
  formatted: mongoose.Schema.Types.Mixed
});

/**
 * Hash the password for security.
 * "Pre" is a Mongoose middleware that executes before each user.save() call.
 */

workoutSchema.pre('save', function(next) {
  var workout = this;

  if (workout.isModified('raw')) {
    try {
      workout.formatted = swimParser(workout.get('raw'));
      workout.markModified('formatted');
    } catch(ex) {
      return next(ex);
    }
  }
  return next();
});

workoutSchema.methods.totalTime = function() {
  var totalTime = 0;

  if (workout.formatted) {
    totalTime = work.formatted.totalTime();
  }

  return totalTime;
};

workoutSchema.methods.totalYards = function() {
  var totalYards = 0;

  if (workout.formatted) {
    totalYards = work.formatted.totalYards();
  }

  return totalYards;
};

workoutSchema.methods.totalDistance = function() {
  var totalDistance = 0;

  if (workout.formatted) {
    totalDistance = work.formatted.totalDistance();
  }

  return totalDistance;
};

module.exports = mongoose.model('Workout', workoutSchema);
