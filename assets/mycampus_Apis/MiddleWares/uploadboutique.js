const path = require('path');
const multer  = require('multer')

var storate = multer.diskStorage({
    destination:function (req,file,cb){
 cb(null,'upload/pub')
    },
    filename:function(req,file,cb){
        let ext = path.extname(file.originalname)
        cb(null,Date.now()+ext)
            }
   // req.body.email+req.body.phone
})
var upload = multer({
    storage:storate,
    fileFilter:function (req,file,callback){
        callback(null, true) 
     /*  if(file.mimetype=="image/png" || file.mimetype =="image/jpg"){
    callback(null, true) 
}else{ 
    console.log("seul les fichiers jpg et png sont pris en charge ")
    callback(null, false)
}*/
    },
    limits: {
        fileSize:1024*1024*8
    }
})

module.exports=upload
