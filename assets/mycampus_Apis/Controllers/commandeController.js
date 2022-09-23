const Commande = require('../Models/commande')
const mongoose =require('mongoose')
const fs = require('fs')

//voir la liste des employes
const index = (req,res,next)=>{
    Commande.find()
.then(response =>{
    res.json({
        response
    })
})
.catch(error =>{
    res.json({
        message:'une erreur est survenu!'
    })
})
}
//rechercher un employe par son id
const show =(req,res,next)=>{
    let CommandeID =req.body.CommandeID
    Commande.findById(CommandeID
        )
    .then(response =>{
        res.json({
            response
        })
    })
    .catch(error =>{
        res.json({
            message:'une erreur est survenu!'
        })
    })
    }
    //add employer
const store =(req,res,next)=>{
    let commande= new Commande({
        date:req.body.date,
        id_user:req.body.user_id,
        id_partenaire:req.body.id_partenaire,
        id_produit:req.body.id_produit,
        qte:req.body. qte,
        })
    
    commande.save()
        .then(response =>{
             
            res.json({
                message:'Commande creer avec succes',
                response
          })
        })
       .catch(error =>{
           res.json({
               message:error
           })
       })
}

   
const destroy =(req,res,next)=>{
    
let CommandeID=req.body.CommandeID
Commande.findById(req.body.CommandeID)
    .then(response =>{
//supression de l utilisateur
Commande.findByIdAndRemove(CommandeID)
.then(response =>{
    res.json({
        message:' Commande supprimer   avec succes',
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la suppression du Commande'
   })
})
        
    })
    .catch(error =>{
        res.json({
            message:error.messag
        })
    })

}
module.exports={
    index,destroy,show,store
}