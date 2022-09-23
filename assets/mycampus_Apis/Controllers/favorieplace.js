const   Favorieplace = require('../Models/favorieplace');
const bcrypt =require('bcryptjs');
const jwt = require('jsonwebtoken');
const { json } = require('body-parser');
const { userInfo } = require('node:os');
const fs = require('fs')
const  Lieu =require('../Models/lieu')
const index = (req,res,next)=>{
    let favorieplaceID= req.body.favorieplaceID;
    let favoris =[]
    Favorieplace.find()
    .then(response =>{
        Lieu.findById(response.id_lieu).then(lieu=>{
            res.json({
                lieu
            })
        });
        res.json({
            response
        })
    })
    .catch(error =>{
        res.json({
            message:error
        })
    })
    }

const store=(req,res,next)=>{
   
        let favorieplace = new Favorieplace({
            id_lieu:req.body.id_lieu,
            user_id:req.body.user_id
        });
       
        favorieplace.save().then(favorieplace =>{
           res.json({
               message:"lieu favorie  ajouter avec succes"
           })
        }).catch(error=>{
               res.json({
                   error:error.message,
               })
        });

  
    
}

const show =(req,res,next)=>{
    let favorieplaceID= req.body.favorieplaceID
console.log(req.body.favorieplaceID);
Favorieplace.findById(favorieplaceID)
    .then(response =>{
        Lieu.findById(response.id_lieu).then(lieu=>{
            res.json({
                lieu
            })
        });
        
    })
    .catch(error =>{
        res.json({
            error:`une erreur est survenu!${error}`
        })
    })
    }
    
   
    const destroy =(req,res,next)=>{
        var path ='';
        let favorieplaceID= req.body.favorieplaceID
        
       
                Favorieplace.findByIdAndDelete(favorieplaceID)
        .then(response =>{
           res.json({
                message:'favorie supprimer   avec succes',
          });
        })
        .catch(error =>{
           res.json({
               message:`une erreur est survenu lors de la suppression de favorie ${error}`
           })
        })
    
        }
module.exports ={
    store,index,show,destroy
}