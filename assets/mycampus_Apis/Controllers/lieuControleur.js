const Lieu = require('../Models/lieu')
const mongoose =require('mongoose')
const fs = require('fs')

//voir la liste des employes
const index = (req,res,next)=>{
    Lieu.find()
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
    let LieuID =req.body.LieuID
    Lieu.findById(LieuID
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
    let lieu= new Lieu({
        intitule:req.body.intitule,
        id_user:req.body.id_user,
        description:req.body.description,
        image:req.body.image,
        lat:req.body.lat,
        long:req.body.long,
        rating:req.body.rating,
        id_campus:req.body.id_campus,
        id_type:req.body.id_type
       
    })
    if(req.files){
        let path ='';
        req.files.forEach(function(files,index,array) {
            path =path +files.path +',';
        });
        path =path.substring(0,path.lastIndexOf(","))
        lieu.image = path;
    }
  lieu.save()
        .then(response =>{
            console.log(response);
             
            res.json({
                message:'lieu creer avec succes',
                response
          })
        })
       .catch(error =>{
           res.json({
               message:error
           })
       })
}
// modifier un employer
const update =(req,res,next) =>{
    var image="";
    let LieuID =req.body.LieuID
    let updateData={
        intitule:req.body.intitule,
        id_user:req.body.id_user,
        description:req.body.description,
        image:req.body.image,
        lat:req.body.lat,
        long:req.body.long,
        rating:req.body.rating,
        id_campus:req.body.id_campus,
        id_type:req.body.id_type

    }
    
    Lieu.findByIdAndUpdate(LieuID,{$set:updateData})
.then(response =>{
    res.json({
        message:'lieu modifier  avec succes',
        
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la modification du lieu'
   })
})
    

}

updateimage=(req,res,next)=>{
    let LieuID=req.body.LieuID;
    var path ='';
    Lieu.findById(req.body.LieuID)
    .then(response =>{
        path =response.image.split(',')});
}
   
const destroy =(req,res,next)=>{
    var path ='';
let LieuID=req.body.LieuID
Lieu.findById(req.body.LieuID)
    .then(response =>{
        
path =response.image.split(',')
//
//supression de l utilisateur
Lieu.findByIdAndRemove(LieuID)
.then(response =>{
  
path.forEach(path=>{
    fs.unlink(path, (err) => {
        if (err) {
        console.error(err)
        
        }});
})
    res.json({
        message:' lieu supprimer   avec succes',
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la suppression du lieu'
   })
})
        
    })
    .catch(error =>{
        res.json({
            message:error.message==="Cannot read property 'split' of null" ? 'image non existante':error.message,
        })
    })

}
module.exports={
    index,destroy,show,store,update
}