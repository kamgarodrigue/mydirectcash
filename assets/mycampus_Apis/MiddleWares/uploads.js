const path = require('path');
const multer  = require('multer')

var storate = multer.diskStorage({
    destination:function (req,file,cb){
 cb(null,'upload/UserProfil')
    },
    filename:function(req,file,cb){
let ext = path.extname(file.originalname)
cb(null,Date.now()+ext)
    }
    
})
var upload = multer({
    storage:storate,
    fileFilter:function (req,file,callback){
      
    callback(null, true) 

    },
    limits: {
        fileSize:1024*1024*8
    }
})
module.exports=upload
