const express = require('express');
const router  = express.Router();
const upload =require('../MiddleWares/uploadspartenaire')
const AuthController =require('../Controllers/partenaireController');
const authenticate =require('../MiddleWares/Authenticate')
router.get('/',AuthController.index);
router.post('/register',upload.single('avatar'),AuthController.register);
router.post('/login',AuthController.login);
router.get('/show',AuthController.show);
router.post('/update',upload.single('avatar'),AuthController.update);
router.post('/destroy',AuthController.destroy);
module.exports =router
//,authent