const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const favorieplaceSchema = new Schema({
    id_lieu:{
        type:String,
       
    },
    user_id:{
        type:String,
       
    },
   
     
},{timestamps:true}
);
favorieplaceSchema.plugin(uniqueValidator);
const favorieplace = mongoose.model('favorieplace',favorieplaceSchema);
module.exports = favorieplace;