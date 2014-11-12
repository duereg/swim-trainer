require('songbird');
var Workout = require('../models/Workout');
var apiCatch = require('./api-catch');

exports.getWorkouts = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.find({'userId': req.user.id})
    .then(function(workouts){
      res.status(200).send(workouts);
    })
    .catch(apiCatch(res));
};

exports.getWorkout = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.findOne({_id: req.params.id, userId: req.user.id})
    .then(function(origWorkout) {
      res.status(200).send(origWorkout);
    })
    .catch(apiCatch(res));
}
