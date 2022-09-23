const jwt  = require('jsonwebtoken');

const authenticate =(req,res,next)=>{
    try{
const token = req.headers.authorization.split('')[1];
const decode =jwt.verify(token, '09f26e402586e2faa8da4c98a35f1b20d6b033c6097befa8be3486a829587fe2f90a832bd3ff9d42710a4da095a2ce285b009f0c3730cd9b8e1af3eb84df6611');
req.user =decode
next()
    }catch(error){
 res.json({
     message:"erreur d authentification"
 })
    }
}
module.exports=authenticate