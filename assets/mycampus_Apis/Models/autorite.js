const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const AutoriteSchema = new Schema({
    Name:{
        type:String,
       
    },
    
    email:{
        type:String,
        unique: true,
        match: /.+\@.+\..+/,
    
    },
    fonction:{
        type:String,
        
    },
    lieudeservice:{
        type:String,
        
    },
    address:{
        type:String,
        
    },
    Profession:{
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
AutoriteSchema.plugin(uniqueValidator);
const Autorite = mongoose.model('Autorite',AutoriteSchema);
module.exports = Autorite;