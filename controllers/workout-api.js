'use strict';

require('songbird');
var Workout = require('../models/Workout');
var apiCatch = require('./api-catch');
var workoutService = require('../services/workout');

exports.getActivity = function(req, res) {
  workoutService.getRecentWorkouts()
    .then(function(leanWorkouts) {
      res.status(200).send(leanWorkouts);
    })
    .catch(apiCatch(res));
}

exports.getWorkouts = function(req, res) {
  if (!req.user) return res.redirect('/login');

  workoutService.getWorkoutsByUserId(req.user.id)
    .then(function(workouts){
      res.status(200).send(workouts);
    })
    .catch(apiCatch(res));
};

exports.getWorkout = function(req, res) {
  if (!req.user) return res.redirect('/login');

  workoutService.getWorkoutById(req.params.id, req.user.id)
    .then(function(origWorkout) {
      res.status(200).send(origWorkout);
    })
    .catch(apiCatch(res));
};

exports.deleteWorkout = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.remove({_id: req.params.id})
    .then(function(removedWorkout){
      res.status(200).send(removedWorkout);
    })
    .catch(apiCatch(res));
};

exports.postAdd = function(req, res) {
  if (!req.user) return res.redirect('/login');

  var newWorkout = new Workout({
    date: req.body.workout.date,
    raw: req.body.workout.raw,
    userId: req.user.id,
    userFullName: req.user.profile.name
  });

  newWorkout.promise.save()
    .then(function(savedWorkout) {res.status(200).send(savedWorkout);}) //this is weird
    .catch(apiCatch(res));
};

exports.postSave = function(req, res) {
  if (!req.user) return res.redirect('/login');

  workoutService.getWorkoutById(req.params.id, req.user.id)
    .then(function(origWorkout) {
      origWorkout.raw = req.body.workout.raw;
      origWorkout.date = req.body.workout.date;
      origWorkout.userFullName = req.user.profile.name;
      return origWorkout.promise.save();
    })
    .then(function(savedWorkout) {res.status(200).send(savedWorkout);}) //this is weird
    .catch(apiCatch(res));
};
