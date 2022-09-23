const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const typeLieuSchema = new Schema({
    
    intitule:{
        type:String,
        unique: true,
},
image:{
    type:String,
  },
   
     
},{timestamps:true}
);
typeLieuSchema.plugin(uniqueValidator);
const typeLieu = mongoose.model('typeLieu',typeLieuSchema);
module.exports = typeLieu;