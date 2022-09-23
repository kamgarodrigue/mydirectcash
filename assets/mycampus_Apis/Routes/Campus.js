const express = require('express');
const router = express.Router();
const Controller =require('../Controllers/CampusController');
const upload =require('../MiddleWares/uploadsLieu')
router.get('/',Controller.index);
router.post('/show',Controller.show);
router.post('/getallplace',Controller.getallplace);
router.post('/store',upload.array('image[]'), Controller.store);//upload.single('avatar')
router.post('/update',Controller.update);
router.post('/destroy',Controller.destroy);
module.exports=router;