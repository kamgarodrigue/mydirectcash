const express = require('express');
const router  = express.Router();
const upload =require('../MiddleWares/uploadsService')
const RouteController =require('../Controllers/RouteController');
const authenticate =require('../MiddleWares/Authenticate')
router.get('/',RouteController.index);
router.post('/register',RouteController.register);
router.get('/show',RouteController.show);
router.post('/update',RouteController.update);
router.post('/destroy',RouteController.destroy);
module.exports =router
//,authent
