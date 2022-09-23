const Pub = require('../Models/pub')
const mongoose =require('mongoose')
const fs = require('fs')

//voir la liste des employes
const index = (req,res,next)=>{
    Pub.find()
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
    let PubID =req.body.PubID
    Pub.findById(PubID
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
    const newPub =(req,res,next)=>{
    
    Pub.find().where("isnew").equals(req.body.isnew)
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
    let pub= new Pub({
        intitule:req.body.intitule,
        id_user:req.body.id_user,
        description:req.body.description,
        image:req.body.image,
        prix:req.body.prix,
        qte:req.body.qte,
        ratin:req.body.ratin,
        disponibilite:req.body.disponibilite,
        etatdelivraison:req.body.etatdelivraison,
        isnew:req.body.isnew
    })
    if(req.files){
        let path ='';
        req.files.forEach(function(files,index,array) {
            path =path +files.path +',';
        });
        path =path.substring(0,path.lastIndexOf(","))
        pub.image = path;
    }
    pub.save()
        .then(response =>{
             
            res.json({
                message:'Pub creer avec succes',
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
    let PubID =req.body.PubID
    let updateData={
        intitule:req.body.intitule,
        id_user:req.body.idpub,
        description:req.body.description,
        image:req.body.image,
        prix:req.body.prix,
        qte:req.body.qte,
        ratin:req.body.ratin,
        disponibilite:req.body.disponibilite,
        etatdelivraison:req.body.etatdelivraison,
        isnew:req.body.isnew

    }
    
    Pub.findByIdAndUpdate(PubID,{$set:updateData})
.then(response =>{
    res.json({
        message:'Pub modifier  avec succes',
        
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la modification du Pub'
   })
})
    

}

updateimage=(req,res,next)=>{
    let PubID=req.body.PubID;
    var path ='';
    Pub.findById(req.body.PubID)
    .then(response =>{
        path =response.image.split(',')});
}
   
const destroy =(req,res,next)=>{
    var path ='';
let PubID=req.body.PubID
Pub.findById(req.body.PubID)
    .then(response =>{
        
path =response.image.split(',')
//
//supression de l utilisateur
Pub.findByIdAndRemove(PubID)
.then(response =>{
  
path.forEach(path=>{
    fs.unlink(path, (err) => {
        if (err) {
        console.error(err)
        
        }});
})
    res.json({
        message:' Pub supprimer   avec succes',
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la suppression du Pub'
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
    index,destroy,show,store,update,newPub
}