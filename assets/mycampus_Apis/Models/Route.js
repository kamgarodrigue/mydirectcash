const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const RouteSchema = new Schema({
    description:{
        type:String,
       
    },
    intitule:{
        type:String,
        unique: true,
        
    
    },
    points:{
        type:Array,
      
        
    
    },
   
   
     
},{timestamps:true}
);
RouteSchema.plugin(uniqueValidator);
const route = mongoose.model('route',RouteSchema);
module.exports = route;