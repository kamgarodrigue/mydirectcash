const express = require('express');
const router  = express.Router();

const Controller =require('../Controllers/commandeController');
const authenticate =require('../MiddleWares/Authenticate')
router.get('/',authenticate,Controller.index);
router.post('/store',Controller.store);
router.get('/show',Controller.show);
router.post('/destroy',Controller.destroy);
module.exports =router
//,authent