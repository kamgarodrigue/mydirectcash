const Boutique = require('../Models/boutique')
const mongoose =require('mongoose')
const fs = require('fs')

//voir la liste des employes
const index = (req,res,next)=>{
    Boutique.find()
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
    let BoutiqueID =req.body.BoutiqueID
    Boutique.findById(BoutiqueID
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
    let pub= new Boutique({
        intitule:req.body.intitule,
        description:req.body.description,
        image:req.body.image,
        id_partenaire:req.body.id_partenaire,
        id_categoris:req.body.id_categoris,
       
       
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
                message:'Boutique creer avec succes',
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
    let PubID =req.body.boutiqueID
    let updateData={
        intitule:req.body.intitule,
        description:req.body.description,
        image:req.body.image,
        id_partenaire:req.body.id_partenaire,
        id_categoris:req.body.id_categoris,
    }
    
    Pub.findByIdAndUpdate(PubID,{$set:updateData})
.then(response =>{
    res.json({
        message:'boutique modifier  avec succes',
        
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
let PubID=req.body.boutiqueId
Pub.findById(req.body.boutiqueId)
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
        message:' boutique supprimer   avec succes',
  })
})
.catch(error =>{
   res.json({
       message:'une erreur est survenu lors de la suppression du boutique'
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