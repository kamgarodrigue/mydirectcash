const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const boutiqueSchema = new Schema({
    intitule:{
        type:String,
        
    },
    id_partenaire:{
        type:String,
        },
        description:{
        type:String,
        
         }, 
    image:{
      type:String,
    },
    id_categoris:{
        type:Number
    }
    
   
    
   
    
     
},{timestamps:true}
);
const boutique = mongoose.model('boutique',boutiqueSchema);
module.exports =boutique;