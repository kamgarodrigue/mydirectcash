const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const User = require('./User');
const pubSchema = new Schema({
    intitule:{
        type:String,
        
    },
    id_user:{
        type:String,
        },
        description:{
        type:String,
        
         }, 
    image:{
      type:String,
    },
    prix:{
        type:Number
    }
    ,qte:{
        type:Number
    },
    ratin:{
        type:Number
    },
    disponibilite:{
        type:Boolean
    },
    isnew:{
        type:Boolean
    },
    etatdelivraison:{
        type:String
    },
    user:{
        type:[]
    },
    
     
},{timestamps:true}
);
const pub = mongoose.model('pub',pubSchema);
module.exports =pub;