'use strict';

var mongoose = require('mongoose');
var swimParser = require('fit-parser');

var workoutSchema = new mongoose.Schema({
  userId: {type: mongoose.Schema.Types.ObjectId, required: true},
  userFullName: String,
  date: {type: Date, default: Date.now},
  raw: String,
  formatted: mongoose.Schema.Types.Mixed
});

/**
 * Hash the password for security.
 * "Pre" is a Mongoose middleware that executes before each user.save() call.
 */

workoutSchema.pre('save', function(next) {
  var workout = this;

  try {
    workout.formatted = swimParser(workout.get('raw')).toJSON();
    workout.markModified('formatted');
  } catch(ex) {
    return next(ex);
  }

  return next();
});

workoutSchema.methods.totalTime = function() {
  var totalTime = 0;

  if (this.formatted) {
    totalTime = this.formatted.totalTime();
  }

  return totalTime;
};

workoutSchema.methods.totalYards = function() {
  var totalYards = 0;

  if (this.formatted) {
    totalYards = this.formatted.totalYards();
  }

  return totalYards;
};

workoutSchema.methods.totalDistance = function() {
  var totalDistance = 0;

  if (this.formatted) {
    totalDistance = this.formatted.totalDistance();
  }

  return totalDistance;
};

module.exports = mongoose.model('Workout', workoutSchema);
