var express = require('express');
var passport = require('passport');
var passportConf = require('./config/passport');

/**
 * Controllers (route handlers).
 */
var homeController = require('./controllers/home');
var userController = require('./controllers/user');
var apiController = require('./controllers/api');
var contactController = require('./controllers/contact');
var workoutController = require('./controllers/workout');
var workoutApiController = require('./controllers/workout-api');

var router = express.Router();

router.get('/', homeController.index);
router.get('/workouts', workoutController.getWorkouts);
router.get('/workouts/addLift', workoutController.getAddLift);
router.get('/workouts/addSimple', workoutController.getAddSimple);
router.get('/workouts/addText', workoutController.getAddText);
router.get('/workouts/edit/:id', workoutController.getEdit);

//TODO: Add view page, to view other people's workouts
router.post('/v1/workouts/', workoutApiController.postAdd);
router.post('/v1/workouts/:id', workoutApiController.postSave);
router.get('/v1/workouts', workoutApiController.getWorkouts);
router.get('/v1/workout/:id', workoutApiController.getWorkout);
router.delete('/v1/workouts/:id', workoutApiController.deleteWorkout);

router.get('/login', userController.getLogin);
router.post('/login', userController.postLogin);
router.get('/logout', userController.logout);
router.get('/forgot', userController.getForgot);
router.post('/forgot', userController.postForgot);
router.get('/reset/:token', userController.getReset);
router.post('/reset/:token', userController.postReset);
router.get('/signup', userController.getSignup);
router.post('/signup', userController.postSignup);
router.get('/contact', contactController.getContact);
router.post('/contact', contactController.postContact);

router.get('/account', passportConf.isAuthenticated, userController.getAccount);
router.post('/account/profile', passportConf.isAuthenticated, userController.postUpdateProfile);
router.post('/account/password', passportConf.isAuthenticated, userController.postUpdatePassword);
router.post('/account/delete', passportConf.isAuthenticated, userController.postDeleteAccount);
router.get('/account/unlink/:provider', passportConf.isAuthenticated, userController.getOauthUnlink);

/**
 * API examples routes.
 */

router.get('/api', apiController.getApi);
router.get('/api/facebook', passportConf.isAuthenticated, passportConf.isAuthorized, apiController.getFacebook);

/**
 * OAuth sign-in routes.
 */

router.get('/auth/facebook', passport.authenticate('facebook', { scope: ['email'] }));
router.get('/auth/facebook/callback', passport.authenticate('facebook', { failureRedirect: '/login' }), function(req, res) {
  res.redirect(req.session.returnTo || '/');
});
router.get('/auth/google', passport.authenticate('google', { scope: 'profile email' }));
router.get('/auth/google/callback', passport.authenticate('google', { failureRedirect: '/login' }), function(req, res) {
  res.redirect(req.session.returnTo || '/');
});


module.exports = router;
