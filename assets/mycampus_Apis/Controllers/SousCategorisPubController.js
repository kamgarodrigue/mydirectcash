 mongoose =require('mongoose')
const SousCategorisPubconst = require('../Models/SousCategorisPub')
const Lieu=require('../Models/lieu')
const fs = require('fs')

const index = (req,res,next)=>{
    SousCategorisPubconst.find()
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
/*const getpubbycate=(req,res,next)=>{
    let Lieutypelieu =req.body.typelieu;
    let id_campus =req.body.id_campus;
    Categoris.find().where('id_campus').equals(id_campus).where('id_type').equals(Lieutypelieu).exec((err,lieu)=>{
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

}*/
const store =(req,res,next)=>{
    let type= new SousCategorisPubconst({
        intitule:req.body.intitule,
        image:req.body.image,
        id_Categoris:req.body.id_Categoris
           
    })
    if(req.files){
        let path ='';
        req.files.forEach(function(files,index,array) {
            path =path +files.path +',';
        });
        path =path.substring(0,path.lastIndexOf(","))
        type.image = path;
    }
    type.save()
        .then(response =>{
             
            res.json({
                message:'type creer avec succes',
                response
          })
        })
       .catch(error =>{
           res.json({
               message:error
           })
       })
}
module.exports={
    index,store
}