const Route= require('../Models/Route');
const bcrypt =require('bcryptjs');
const jwt = require('jsonwebtoken');
const { json } = require('body-parser');
const { userInfo } = require('node:os');

const index = (req,res,next)=>{
    Route.find()
    .then(response =>{
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

const register=(req,res,next)=>{
   
       
        let route = new Route({
            description:req.body.description,
            intitule:req.body.intitule,
            points:req.body.points, 
             
           
        });
       
        route.save().then(route =>{
           res.json({
               message:"Route creer avec succes",
               route
           })
        }).catch(error=>{
               res.json({
                   error:error.message,
               })
        });


    
}

const show =(req,res,next)=>{
    let RouteID= req.body.RouteID
    Route.findById(RouteID)
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
    const update =(req,res,next) =>{
        console.log(req.body.routeID);
        
        let updateData={
            routeID:req.body.routeID,
            description:req.body.description,
            intitule:req.body.intitule,
            points:req.body.points, 
            
        };
     
        Route.findByIdAndUpdate(updateData.routeID,{$set:updateData})
    .then(response =>{
        res.json({
            message:'modification effectuer avec success',
      })
    })
    .catch(error =>{
       res.json({
           message:'une erreur est survenu lors de la modification de votre compte'
       })
    })
    }
   
    const destroy =(req,res,next)=>{
     
        let RouteID= req.body.routeID
        console.log(RouteID);
        
        Route.findByIdAndRemove(RouteID)
        .then(response =>{
          
            res.json({
                message:'Route  supprimer   avec succes',
          })
        })
        .catch(error =>{
           res.json({
               message:'une erreur est survenu lors de la suppression de la Route'
           })
        })
        }
module.exports ={
    register,index,show,update,destroy
}