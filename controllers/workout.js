require('songbird');
var Workout = require('../models/Workout');
var apiCatch = require('./api-catch');

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

exports.postAdd = function(req, res) {
  if (!req.user) return res.redirect('/login');

  var newWorkout = new Workout({ date: req.body.date, raw: req.body.workout, userId: req.user.id});

  newWorkout.promise.save()
    .then(function(savedWorkout) {res.status(200).send(savedWorkout);}) //this is weird
    .catch(apiCatch(res));
}

exports.postSave = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.findOne({_id: req.params.id, userId: req.user.id})
    .then(function(origWorkout) {
      origWorkout.raw = req.body.workout.raw;
      origWorkout.date = req.body.workout.date;
      return origWorkout.promise.save();
    })
    .then(function(savedWorkout) {res.status(200).send(savedWorkout);}) //this is weird
    .catch(apiCatch(res));
}

exports.getAdd = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/add', {
    title: 'Workouts'
  });
}

exports.getEdit = function(req, res) {
  if (!req.user) return res.redirect('/login');

  Workout.promise.findOne({_id: req.params.id, userId: req.user.id}).then(function(origWorkout) {
    res.render('workouts/add', {
      title: 'Workout',
      workout: origWorkout
    });
  });
}
