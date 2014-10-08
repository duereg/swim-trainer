require('songbird');
var Workout = require('../models/Workout');

/**
 * GET /workouts
 * Workouts list page.
 */

exports.getWorkouts = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.find({'userId': req.user.id}, function(err, workouts) {
    if (!!err) {
      console.log(err);
      res.redirect('/')
    }

    res.render('workouts/list', {
      title: 'Workouts',
      workouts: workouts
    });
  });
};

exports.getAdd = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/add', {
    title: 'Workouts'
  });
}
