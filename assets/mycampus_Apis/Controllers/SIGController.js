const { resolveSoa } = require('dns');
var Gp = require('geoportal-access-lib');
var roads =require('../contours_uy1.json');
const http = require("https");
const { json } = require('express/lib/response');
const { calculeDistantceRoute, direction } = require('./roadService');




const geocode= (req,res,next)=>{
    var result ;
Gp.Services.geocode({
    apiKey : "22726iz9m8ficsgf2hmiicpd", // clef d'accès à la plateforme
    location : req.body.text,            // localisant à géocoder
    filterOptions : {
        type : ["StreetAddress"]    // type de localisant
    },
    onSuccess : function (result) {
        // exploitation des resultats : "result" est de type Gp.Services.GeocodeResponse
        res.json({
            message:'  avec succes',
            result
        })
    },
    onerror:function (result) {
        // exploitation des resultats : "result" est de type Gp.Services.GeocodeResponse
        res.json({
            message:'  avec succes',
            result
        })
    },
 
});

}
const reverseGeocode= (req,res,next)=>{
    Gp.Services.reverseGeocode({
        apiKey :"22726iz9m8ficsgf2hmiicpd", // clef d'accès à la plateforme
        position : {                         // position de recherche
            x: req.body.x,
            y: req.body.y
        },
        filterOptions : {
            type : ["PositionOfInterest"]    // type de localisant
        },
        onSuccess : function (result) {
            // exploitation des resultats : "result" est de type Gp.Services.GeocodeResponse
            res.json({
                message:'  avec succes',
                result
            })
        },
        onerror:function (result) {
            // exploitation des resultats : "result" est de type Gp.Services.GeocodeResponse
            res.json({
                message:'  avec succes',
                result
            })
        },
     
    });
}
const autoComplete= (req1,res,next)=>{
    const options = {
        "method": "GET",
        "hostname": "forward-reverse-geocoding.p.rapidapi.com",
        "port": null,
        "path": "/v1/search?q=New%20York%20City%20NY%20USA&accept-language=en&polygon_threshold=0.0",
        "headers": {
            "X-RapidAPI-Host": "forward-reverse-geocoding.p.rapidapi.com",
            "X-RapidAPI-Key": "SIGN-UP-FOR-KEY",
            "useQueryString": true
        }
    };
    
    const req = http.request(options, function (res) {
        const chunks = [];
    
        res.on("data", function (chunk) {
            chunks.push(chunk);
        });
    
        res.on("end", function () {
            const body = Buffer.concat(chunks);
            console.log(body.toString());
        });
    });
    
    req.end();
    res.json({
        message:'  avec succes',
        roads
    })
    

}
const itineraire1=(req,res,next)=>{
    var dataroad=[[11.505153179168701,3.85997282722233],[11.505045890808105,3.8598550777334695],[11.504906415939331,3.859694510222356],[11.504777669906616,3.8595553516881522],[11.504734754562378,3.859405488625845],[11.5047025680542,3.8592556255370627],[11.504670381546019,3.8591164669309657],[11.504648923873901,3.8589773083020704],[11.50462746620178,3.8588595586751993],[11.504606008529663,3.858731104518163],[11.504584550857544,3.8586133548571584],[11.504573822021484,3.858484900662897],[11.504530906677246,3.858356446449209],[11.504509449005125,3.858217287695801],[11.504487991333008,3.8580888334416565],[11.50444507598877,3.8579603791680976],[11.504402160644531,3.8578319248751116],[11.504359245300293,3.857703470562699],[11.504273414611816,3.8575429026448815],[11.504219770431517,3.8574251528192],[11.504176855087278,3.857328812040605],[11.504123210906982,3.857189653118882],[11.504069566726685,3.857093312313583],[11.504037380218506,3.8569862669615413],[11.503962278366089,3.8568792215960275],[11.503908634185791,3.8567828807555253],[11.503876447677612,3.8566758353644017],[11.503812074661255,3.856579494500847],[11.503747701644897,3.8564724490841007]]
res.json({
  "diastance":  calculeDistantceRoute(dataroad)
})
}
const getRoute=(req,res,next)=>{
    //var lat1="3.85997282722233"; 
    //var long1="11.505153179168701"
    var lat1="3.85997282722233"; 
    var long1="11.505153179168701"
    var poli=[];
    roads["features"].forEach(element => {
        element["geometry"]["coordinates"].forEach(routes=> {
           
               

              if((routes[1].toString()).includes(lat1.substring(0,5))&& (routes[0].toString()).includes(long1.substring(0,5)) ){
poli.push(element);

               }
           
        });
    });
    res.json({
        message:'  avec succes',
        poli
    })   
    
}
const itineraires= (req,res,next)=>{
// point1=[11.49856299161911,3.854199403380822];
 // point2=[11.49948064237833,3.854831641868601];
 // point1=[11.505153179168701,3.85997282722233];
 point1=   [
    11.500440537929535,
    3.8548721184965182
  ],
  point2= [
    11.503812074661255,
    3.856579494500847
  ];
  
  res.json({
  "linestring" : direction(point1,point2)
  })

}

module.exports={
    geocode,reverseGeocode, autoComplete,itineraires,getRoute,itineraire1
}