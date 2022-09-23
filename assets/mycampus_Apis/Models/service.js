const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const serviceSchema = new Schema({
    description:{
        type:String,
       
    },
    intitule:{
        type:String,
        unique: true,
        
    
    },
     avatar:{
        type:String,
         }, 
   
     
},{timestamps:true}
);
serviceSchema.plugin(uniqueValidator);
const service = mongoose.model('service',serviceSchema);
module.exports = service;