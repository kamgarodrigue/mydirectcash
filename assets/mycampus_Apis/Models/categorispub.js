const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const categoriPubSchema = new Schema({
    
    intitule:{
        type:String,
        unique: true,
},
image:{
    type:String,
  },
   
     
},{timestamps:true}
);
categoriPubSchema.plugin(uniqueValidator);
const categoriPub = mongoose.model('categoriPub',categoriPubSchema);
module.exports = categoriPub;