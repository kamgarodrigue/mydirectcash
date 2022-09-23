const Service = require('../Models/service');
const bcrypt =require('bcryptjs');
const jwt = require('jsonwebtoken');
const { json } = require('body-parser');
const { userInfo } = require('node:os');
const fs = require('fs')

const index = (req,res,next)=>{
    Service.find()
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
   
       
        let service = new Service({
            description:req.body.description,
            intitule:req.body.intitule,
            avatar:req.body.avatar, 
             
           
        });
        if(req.file){
            service.avatar = req.file.path
        }
        service.save().then(service =>{
           res.json({
               message:"Service creer avec succes",
               service
           })
        }).catch(error=>{
               res.json({
                   error:error.message,
               })
        });


    
}

const show =(req,res,next)=>{
    let ServiceID= req.body.ServiceID
    Service.findById(ServiceID)
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
        console.log(req.body.serviceID);
        
        let updateData={
            serviceID:req.body.serviceID,
            description:req.body.description,
            intitule:req.body.intitule,
            avatar:req.body.avatar, 
            
        };
        if(req.file){
            updateData.avatar = req.file.path
         
            Service.findById(updateData.serviceID).then(service=>{
                console.log(service);
                fs.unlink(service.avatar, (err) => {
                    if (err) {
                    console.error(err)
                    
                    }});
          });
        }
        Service.findByIdAndUpdate(updateData.serviceID,{$set:updateData})
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
     
        let serviceID= req.body.serviceID
        console.log(serviceID);
        Service.findById(serviceID).then(service=>{
            console.log(service);
            fs.unlink(service.avatar, (err) => {
                if (err) {
                console.error(err)
                
                }});});
                Service.findByIdAndRemove(serviceID)
        .then(response =>{
          
            res.json({
                message:'Service  supprimer   avec succes',
          })
        })
        .catch(error =>{
           res.json({
               message:'une erreur est survenu lors de la suppression de la Service'
           })
        })
        }
module.exports ={
    register,index,show,update,destroy
}