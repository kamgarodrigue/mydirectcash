const Autorite = require('../Models/autorite');
const bcrypt =require('bcryptjs');
const jwt = require('jsonwebtoken');
const { json } = require('body-parser');
const { userInfo } = require('node:os');
const fs = require('fs')

const index = (req,res,next)=>{
    Autorite.find()
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
    bcrypt.hash(req.body.password,10,function(err,hashedPass){
        if(err){
            res.json({
                error:err
            });
        }
        let autorite = new Autorite({
            Name:req.body.userName,
            email:req.body.email,
             phone:req.body.phone, 
             address:req.body.address,
            birthDay:req.body.birthDay,
            avatar:req.body.avatar,
            fonction:req.body.fonction,
            Profession:req.body.Profession,
            lieudeservice:req.body.lieudeservice,
            password:hashedPass
        });
        if(req.file){
            autorite.avatar = req.file.path
        }
        autorite.save().then(user =>{
           res.json({
               message:"Autorite creer avec succes"
           })
        }).catch(error=>{
               res.json({
                   error:error.message,
               })
        });

    });
    
}
const  login =(req,res,next)=>{
    var userName= req.body.email;
    var password = req.body.password;
    Autorite.findOne({$or:[{email:userName},{phone:userName}]})
    .then(autorite=>{
     //   console.log(autorite);
        if(autorite){
            bcrypt.compare(password,autorite.password,function(err,result){
                if(err){
                   res.json({
                       error:err,
                   }); 
                }
                if(result){
                    let token =jwt.sign({name:autorite.userName},'09f26e402586e2faa8da4c98a35f1b20d6b033c6097befa8be3486a829587fe2f90a832bd3ff9d42710a4da095a2ce285b009f0c3730cd9b8e1af3eb84df6611',{expiresIn:'1h'})
                    res.json({
                        message:"connexion reussie",token
                        
                    })
                }else{
                    res.json({
                        massage:"mot de passe incorecte"
                    })
                }
    
            });
        }else{
            res.json({
                message:"utilisateur non existant"
            })
        }
    })
}
const show =(req,res,next)=>{
    let userID= req.body.userID
    Autorite.findById(userID)
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
        console.log(req.body.userID);
        
        let updateData={
            userID:req.body.userID,
            Name:req.body.userName,
            email:req.body.email,
             phone:req.body.phone, 
             address:req.body.address,
            birthDay:req.body.birthDay,
            intbusness:req.body.intbusness,
            address:req.body.address,
            avatar:req.body.avatar,
            fonction:req.body.fonction,
            Profession:req.body.Profession,
            lieudeservice:req.body.lieudeservice,
            
        };
        if(req.file){
            updateData.avatar = req.file.path
         
            Autorite.findById(updateData.userID).then(user=>{
                console.log(user);
                fs.unlink(user.avatar, (err) => {
                    if (err) {
                    console.error(err)
                    
                    }});
          });
        }
        Autorite.findByIdAndUpdate(updateData.userID,{$set:updateData})
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
     
        let userID= req.body.userID
        console.log(userID);
        Autorite.findById(userID).then(user=>{
            console.log(user);
            fs.unlink(user.avatar, (err) => {
                if (err) {
                console.error(err)
                
                }});});
                Autorite.findByIdAndRemove(userID)
        .then(response =>{
          
            res.json({
                message:'personaliter  supprimer   avec succes',
          })
        })
        .catch(error =>{
           res.json({
               message:'une erreur est survenu lors de la suppression de la personaliter'
           })
        })
        }
module.exports ={
    register,login,index,show,update,destroy
}