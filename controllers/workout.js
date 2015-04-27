'use strict';

require('songbird');
var Workout = require('../models/Workout');
var workoutService = require('../services/workout');

exports.getWorkouts = function(req, res) {
  if (!req.user) return res.redirect('/login');

  workoutService.getWorkoutsByUserId(req.user.id)
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

exports.getAddLift = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/addLift', {
    title: 'Workouts'
  });
};

exports.getAddSimple = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/addSimple', {
    title: 'Workouts'
  });
};

exports.getAddText = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/addText', {
    title: 'Workouts'
  });
};

exports.getEdit = function(req, res) {
  console.log('thinking about redirecting...', req.user);

  if (!req.user) return res.redirect('/login');

  //this should be smart enough to toggle between simple and text
  workoutService.getWorkoutById(req.params.id, req.user.id)
    .then(function(origWorkout) {
      console.log('in edit endpoint');

      var url;
      if (origWorkout.formatted.sets.length === 0 ||
          origWorkout.formatted.sets[0].name === '---SIMPLE WORKOUT---') {
        url = 'workouts/addSimple';
      } else {
        url = 'workouts/addText';
      }

      res.render(url, {
        title: 'Workout',
        workout: origWorkout
      });
    })
    .catch(function(err){
      //TODO: show 500 here
      res.status(500).send(err);
      // res.redirect('/');
    });
};
