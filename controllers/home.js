'use strict';

/**
 * GET /
 * Home page.
 */
var swimParser = require('fit-parser');
var workoutService = require('../services/workout');
var quotes = require('../models/quotes');
var images = require('../models/images');

exports.index = function(req, res) {
  workoutService.getRecentWorkouts()
    .then(function(workouts){

      workouts.forEach(function(workout){
        workout.formatted = swimParser(workout.raw);
      });

      res.render('home', {
        title: 'Home',
        quotes: quotes,
        images: images,
        activity: workouts
    });
  });
};
