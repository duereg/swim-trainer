require('songbird');
var Workout = require('../models/Workout');

/**
 * GET /workouts
 * Workouts list page.
 */

exports.getWorkouts = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.find({'userId': req.user.id})
    .then(function(workouts){
      res.render('workouts/list', {
        title: 'Workouts',
        workouts: workouts
      });
    })
    .catch(function(err){
      console.log(err);
      res.redirect('/')
    });
};

exports.getAdd = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/add', {
    title: 'Workouts'
  });
}
