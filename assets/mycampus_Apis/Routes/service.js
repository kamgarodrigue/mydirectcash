const express = require('express');
const router  = express.Router();
const upload =require('../MiddleWares/uploadsService')
const AuthController =require('../Controllers/service');
const authenticate =require('../MiddleWares/Authenticate')
router.get('/',AuthController.index);
router.post('/register',upload.single('avatar'),AuthController.register);
router.get('/show',AuthController.show);
router.post('/update',upload.single('avatar'),AuthController.update);
router.post('/destroy',AuthController.destroy);
module.exports =router
//,authent