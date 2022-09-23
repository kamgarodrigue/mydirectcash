const express = require('express');
const router  = express.Router();
const sigController =require('../Controllers/SIGController');

router.post('/geocode',sigController.geocode);
router.get('/osmdata',sigController.getRoute);
router.post('/reverseGeocode',sigController.reverseGeocode);
router.get('/autoComplete',sigController.autoComplete);
router.get('/itineraires',sigController.itineraires); 
router.get('/itineraire1',sigController.itineraire1);
module.exports =router