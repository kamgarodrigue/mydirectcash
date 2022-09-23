const express = require('express');
const router  = express.Router();

const Controller =require('../Controllers/favorieplace');
const authenticate =require('../MiddleWares/Authenticate')
router.get('/',Controller.index);
router.post('/store',Controller.store);
router.get('/show',Controller.show);
router.post('/destroy',Controller.destroy);
module.exports =router
//,authent