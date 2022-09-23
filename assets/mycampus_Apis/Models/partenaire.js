const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const partenaireSchema = new Schema({
    Name:{
        type:String,
       
    },
    
    email:{
        type:String,
        unique: true,
        match: /.+\@.+\..+/,
    
    },
    intbusness:{
        type:String,
        
    },
    address:{
        type:String,
        
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
    password:{
        type:String,
        unique: true,
    },
     
},{timestamps:true}
);
partenaireSchema.plugin(uniqueValidator);
const Partenaire = mongoose.model('partenaire',partenaireSchema);
module.exports = Partenaire;