var fs = require('fs');
var path = require('path');

var imagePath = path.join('public', 'img', 'motivation');
var images = fs.readdirSync(imagePath);

module.exports = images;
