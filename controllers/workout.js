'use strict';

require('songbird');
var Workout = require('../models/Workout');

exports.getWorkouts = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.find({'userId': req.user.id})
    .then(function(workouts){
      res.render('workouts/index', {
        title: 'Workouts',
        workouts: workouts
      });
    })
    .catch(function(err){
      //TODO: show 500 here
      console.log(err);
      res.redirect('/');
    });
};

exports.getAdd = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/add', {
    title: 'Workouts'
  });
};

exports.getEdit = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.findOne({_id: req.params.id, userId: req.user.id})
    .then(function(origWorkout) {
      res.render('workouts/add', {
        title: 'Workout',
        workout: origWorkout
      });
    })
    .catch(function(err){
      //TODO: show 500 here
      console.log(err);
      res.redirect('/');
    });
};
