require('songbird');
var Workout = require('../models/Workout');

/**
 * GET /workouts
 * Workouts list page.
 */

var apiCatch = function(res) {
  // apiError => {error: body-of-response, options: requestOptions,
  //              response: full-response-object, statusCode: full-response-object.statusCode}
  return function(apiError) {
    console.warn("Caught API error:", JSON.stringify(apiError));
    if (apiError && apiError.statusCode && apiError.error) {
      res.status(apiError.statusCode).send(apiError.error);
    } else if (apiError && apiError.status && apiError.detail) {
      res.status(parseInt(apiError.status)).send({errors: [apiError]});
    } else if (apiError) {
      res.status(500).send({errors: [apiError]});
    }
    return res;
  };
};

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

  res.format({
    'json': function() {
      Workout.promise.add
        .then(function(accountId) {
          return WishlistsModel.edit(accountId, listId, req.body);
        })
        .then(res.status(200).send)
        .catch(apiCatch(res));
    }
  });
}

exports.getAdd = function(req, res) {
  if (!req.user) return res.redirect('/login');

  res.render('workouts/add', {
    title: 'Workouts'
  });
}
