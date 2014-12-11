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
  if (!req.user) return res.redirect('/login');

  //this should be smart enough to toggle between simple and text
  Workout.promise.findOne({_id: req.params.id, userId: req.user.id})
    .then(function(origWorkout) {
      var url;
      if (origWorkout.formatted.sets[0].name === '---SIMPLE WORKOUT---') {
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
      console.log(err);
      res.redirect('/');
    });
};
