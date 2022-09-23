const express = require('express');
const router = express.Router();
const Controller =require('../Controllers/pubController');
const upload =require('../MiddleWares/uploadsPub')
router.get('/',Controller.index);
router.post('/show',Controller.show);
router.post('/pubmode',Controller.newPub);

router.post('/store',upload.array('image[]'), Controller.store);//upload.single('avatar')
router.post('/update',Controller.update);
router.post('/destroy',Controller.destroy);
module.exports=router;