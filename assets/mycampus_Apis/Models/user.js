const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const userSchema = new Schema({
    userName:{
        type:String,
       
    },
    email:{
        type:String,
        unique: true,
        match: /.+\@.+\..+/,
    
    },
     phone:{
        type:String,
         }, 
    birthDay:{
      type:String
    },
    avatar:{
        type:String
    },
    sexe:{
        type:String
    },
    address:{
        type:String
    },
    password:{
        type:String,
        unique: true,
    },
     
},{timestamps:true}
);
userSchema.plugin(uniqueValidator);
const User = mongoose.model('user',userSchema);
module.exports = User;