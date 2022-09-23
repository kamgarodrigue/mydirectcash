
const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const SousCategorisPubSchema = new Schema({
    
    intitule:{
        type:String,
        unique: true,
},
id_Categoris:{
    type:String,
    unique: true,
},
image:{
    type:String,
  },
   
     
},{timestamps:true}
);
SousCategorisPubSchema.plugin(uniqueValidator);
const categoriPub = mongoose.model('sousCategorisPub',SousCategorisPubSchema);
module.exports = SousCategorisPub;