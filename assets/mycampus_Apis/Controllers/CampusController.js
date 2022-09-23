const Campus = require('../Models/Campus')
const mongoose =require('mongoose')
const fs = require('fs')
const Lieu=require('../Models/lieu')
//voir la liste des employes
const index = (req,res,next)=>{
    Campus.find()
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
const getallplace=(req,res,next)=>{
    let id_campus=req.body.id_campus;
    Lieu.find().where('id_campus').equals(id_campus).exec((err,lieu)=>{
        if(err){
            res.status(500).send({
                message:err
            });
        }
        if(lieu){
        
            res.json({
               lieu,
                
            });
        }
    })

}
//rechercher un employe par son id
const show =(req,res,next)=>{
    let CampusID =req.body.CampusID
    Campus.findById(CampuID
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
    let campus= new Campus({
        intitule:req.body.intitule,
        description:req.body.description,
        image:req.body.image,
        lat:req.body.lat,
        long:req.body.long,
        ratin:req.body.ratin,
       
           
           
    })
    if(req.files){
        let path ='';
        req.files.forEach(function(files,index,array) {
            path =path +files.path +',';
        });
        path =path.substring(0,path.lastIndexOf(","))
        campus.image = path;
    }
    campus.save()
        .then(response =>{
             
            res.json({
                message:'Campus creer avec succes',
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
    let CampusID =req.body.CampusID
    let updateData={
        intitule:req.body.intitule,
       // id_user:req.body.id_user,
        description:req.body.description,
        image:req.body.image,
        lat:req.body.lat,
        long:req.body.long,
        ratin:req.body.ratin,
    }
    
    Campus.findByIdAndUpdate(CampusID,{$set:updateData})
.then(response =>{
    res.json({
        message:'Campus modifier  avec succes',
        
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la modification du Campus'
   })
})
    

}

updateimage=(req,res,next)=>{
    let CampusID=req.body.CampusID;
    var path ='';
    Campus.findById(req.body.CampusID)
    .then(response =>{
        path =response.image.split(',')});
}
   
const destroy =(req,res,next)=>{
    var path ='';
let CampusID=req.body.CampusID
Campus.findById(req.body.CampusID)
    .then(response =>{
        
path =response.image.split(',')
//
//supression de l utilisateur
Campus.findByIdAndRemove(CampusID)
.then(response =>{
  
path.forEach(path=>{
    fs.unlink(path, (err) => {
        if (err) {
        console.error(err)
        
        }});
})
    res.json({
        message:' Campus supprimer   avec succes',
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la suppression du Campus'
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
    index,destroy,show,store,update,getallplace
}