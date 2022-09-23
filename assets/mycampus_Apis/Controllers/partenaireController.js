const Partenaire = require('../Models/partenaire');
const bcrypt =require('bcryptjs');
const jwt = require('jsonwebtoken');
const { json } = require('body-parser');
const { userInfo } = require('node:os');
const fs = require('fs')

const index = (req,res,next)=>{
    Partenaire.find()
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
        let partenaire = new Partenaire({
            Name:req.body.userName,
            email:req.body.email,
             phone:req.body.phone, 
             address:req.body.address,
            birthDay:req.body.birthDay,
            intbusness:req.body.intbusness,
            address:req.body.address,
            avatar:req.body.avatar,
            password:hashedPass
        });
        if(req.file){
            partenaire.avatar = req.file.path
        }
        partenaire.save().then(user =>{
           res.json({
               message:"commercial creer avec succes"
           })
        }).catch(error=>{
               res.json({
                   error:error.message,
               })
        });

    });
    
}
const  login =(req,res,next)=>{
    var userName= req.body.Name;
    var password = req.body.password;
    Partenaire.findOne({$or:[{email:userName},{phone:userName}]})
    .then(partenaire=>{
     //   console.log(partenaire);
        if(partenaire){
            bcrypt.compare(password,partenaire.password,function(err,result){
                if(err){
                   res.json({
                       error:err,
                   }); 
                }
                if(result){
                    let token =jwt.sign({name:partenaire.userName},'09f26e402586e2faa8da4c98a35f1b20d6b033c6097befa8be3486a829587fe2f90a832bd3ff9d42710a4da095a2ce285b009f0c3730cd9b8e1af3eb84df6611',{expiresIn:'1h'})
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
    Partenaire.findById(userID)
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
            
        };
        if(req.file){
            updateData.avatar = req.file.path
         
            Partenaire.findById(updateData.userID).then(user=>{
                console.log(user);
                fs.unlink(user.avatar, (err) => {
                    if (err) {
                    console.error(err)
                    
                    }});
          });
        }
       Partenaire.findByIdAndUpdate(updateData.userID,{$set:updateData})
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
        Partenaire.findById(userID).then(user=>{
            console.log(user);
            fs.unlink(user.avatar, (err) => {
                if (err) {
                console.error(err)
                
                }});});
        Partenaire.findByIdAndRemove(userID)
        .then(response =>{
          
            res.json({
                message:'commerciale supprimer   avec succes',
          })
        })
        .catch(error =>{
           res.json({
               message:'une erreur est survenu lors de la suppression de l employe'
           })
        })
        }
module.exports ={
    register,login,index,show,update,destroy
}