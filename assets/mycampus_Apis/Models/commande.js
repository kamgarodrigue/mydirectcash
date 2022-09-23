const mongoose  = require('mongoose');
const Schema = mongoose.Schema;
var  uniqueValidator  = require ('mongoose-unique-validator') ; 
const commandeSchema = new Schema({
    date:{
        type:String,
       
    },
    user_id:{
        type:String,
       
    },
    id_partenaire:{
        type:String,
       
    },
    id_produit:{
        type:String,
       
    },
    qte:{
        type:Number,
       
    },
   
     
},{timestamps:true}
);
commandeSchema.plugin(uniqueValidator);
const commande = mongoose.model('commande',commandeSchema);
module.exports = commande;