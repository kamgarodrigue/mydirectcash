const { route } = require('express/lib/application');
const { is } = require('express/lib/request');
var roads =require('../contours_uy1.json');

function calculeDistantce(lat1, lon1, lat2, lon2, unit) {
	if ((lat1 == lat2) && (lon1 == lon2)) {
		return 0;
	} 
	else {
		var radlat1 = Math.PI * lat1/180;
		var radlat2 = Math.PI * lat2/180;
		var theta = lon1-lon2;
		var radtheta = Math.PI * theta/180;
		var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
		if (dist > 1) {
			dist = 1;
		}
		dist = Math.acos(dist);
		dist = dist * 180/Math.PI;
		dist = dist * 60 * 1.1515;
		if (unit=="K") { dist = dist * 1.609344 }
		if (unit=="N") { dist = dist * 0.8684 }
    	if (unit=="M") { dist = dist *1.609344*1000 }
		return dist;
	}}
    function calculeDistantceRoute(Route){
        
              var distance=0;
for (let index = 0; index < Route.length-1; index++) {
distance+=calculeDistantce(Route[index][1],Route[index][0],Route[index+1][1],Route[index+1][0],"M");
}
return distance;
    }

    function getNode(r1,r2){
      //  console.log(r1)
        var point;
        for (let i= 0; i < r1.length; i++) {
            
            for (let j = 0; j < r2.length; j++) {

               if(r1[i][0]===r2[j][0] && r1[i][1]===r2[j][1]){
point=r1[i];
               } 
                
                
            }
            
        }
        return point;
    }

    function  routeEnCommun(r1){
       var data=[];
        roads["features"].slice().forEach(route => {
            start1=r1[0];
            start2=route["geometry"]["coordinates"].slice()[0];
             end1=r1.pop();
             end2=route["geometry"]["coordinates"].slice().pop();
            if ( 
             (  start1[0]===start2[0] && start1[1]===start2[1]) || 
             (start1[0]===end2[0] && start1[1]===end2[1]) ||
             (  end1[0]===start2[0] && end1[1]===start2[1]) || 
             (end1[0]===end2[0] && end1[1]===end2[1])
              

                      ) {
                data.push(route["geometry"]["coordinates"].slice());
            }
        });
return data;  


    }

    function  iscontentitem(point,routes){
        var bool=false;
routes.forEach(element => {
    if (element[0]===point[0] && element[1]===point[1] ) {
    bool
    }
});
return bool;
    }

    function getNodeRoutes(routes,start,end){
        var point;
        var data =[];

       /*routes.forEach(route => {
           if (iscontentitem(start,route["geometry"]["coordinates"]) || iscontentitem(end,route["geometry"]["coordinates"])) {
               data.push(route);
           }
       });*/
       for (let i= 0; i < routes.length; i++) {
            
        for (let j = i+1; j < routes.length; j++) {
point=getNode(routes[i]["geometry"]["coordinates"],routes[j]["geometry"]["coordinates"]);

          if(point!=null ){
data.push({
"R1":routes[i],
"R2":routes[j],
"node":point
});
            }
            
            
        }
        
    }
        return data;
    }

    function concat(r1,r2) {
        var data=r2.slice()
       
        data.pop();
       data.push(...r1)
       return data;
    }

    function linkRoute(linkroute1,truncateroute) { 
        var data =[]   // joindre des route
       
       let truncateRoute=truncateroute.slice();
       //console.log(truncateRoute)
      let  linkroute=linkroute1.slice();
      let length1=truncateRoute.length;
      let length2=linkroute.length;
      var length=length1<=length2?length1:length2;
      console.log(length + " "+truncateRoute.length + " "+ linkroute.length );
        for (let index = 0; index < length1; index++) {
          
            console.log(truncateRoute[index].slice().pop())
           for (let j = 0; j < length2; j++) {
               if( ( truncateRoute[index][0][0]===linkroute[j][0][0] && truncateRoute[index][0][1]===linkroute[j][0][1] ) &&  ( truncateRoute[index].slice().pop()[0]===linkroute[j].slice().pop()[0] && truncateRoute[index].slice().pop()[1]===linkroute[j].slice().pop()[1] )){
                        console.log("vrai")
                data.push(truncateRoute[index])
               }else{
                if (truncateRoute[index][0][0]===linkroute[j][0][0] && truncateRoute[index][0][1]===linkroute[j][0][1]) {
                    //console.log(linkroute[j].slice().reverse())
                    //console.log(truncateRoute[index].slice())
                     console.log("pemier===premier " + truncateRoute[index][0] +" "+linkroute[j][0])
                    data.push(concat(truncateRoute[index].slice(),linkroute[j].slice().reverse()))
                    //console.log(concat(truncateRoute[index].slice(),linkroute[j].slice().reverse()))
                }
                if (truncateRoute[index][0][0]===linkroute[j].slice().pop()[0] && truncateRoute[index][0][1]===linkroute[j].slice().pop()[1]) {
                 data.push(concat(truncateRoute[index].slice(),linkroute[j].slice()))
                 console.log("prem===dernier "+ " "+truncateRoute[index][0]+ " "+linkroute[j].slice().pop())
                // console.log(concat(truncateRoute[index].slice(),linkroute[j].slice()))
 
             }
             if (truncateRoute[index].slice().pop()[0]===linkroute[j][0][0] && truncateRoute[index].slice().pop()[1]===linkroute[j][0][1]) {
                 data.push(concat(linkroute[j].slice(),truncateRoute[index].slice()))
                 console.log("dernier==premier "+truncateRoute[index].slice().pop()+" "+linkroute[j][0])
                // console.log(concat(linkroute[j].slice(),truncateRoute[index].slice()))
 
             }
             if (truncateRoute[index].slice().pop()[0]===linkroute[j].slice().pop()[0] && truncateRoute[index].slice().pop()[1]===linkroute[j].slice().pop()[1]) {
              data.push(concat(truncateRoute[index].slice().reverse(),linkroute[j].slice()))
                              console.log("dernier===dernier"+ " " +truncateRoute[index].slice().pop()+" "+ linkroute[j].slice().pop())
                         //     console.log(concat(truncateRoute[index].slice().reverse(),linkroute[j].slice()))
 
          }
               }
              
              
               
           }
            
        }
return data;

    }

    function routeContaint1(point1,point2,routes){ // retoune les route qui contienne A et
        var data=[];
        routes.forEach(route => {
            
               route["geometry"]["coordinates"].forEach(point => {
                  
                   if(point[0]===point1[0]&& point[1]===point1[1] || point[0]===point2[0]&& point[1]===point2[1]){
                    data.push(route);
                   }
              
                                   
             });
            
    
           });
        return data;

    }

    function routecontents(point,routes){
        var data=[];
        for (let index = 0; index < routes.length; index++) {
            for (let j = 0; j < routes[index]["geometry"]["coordinates"].length; j++) {
                if (routes[index]["geometry"]["coordinates"][j][0]===point[0] && routes[index]["geometry"]["coordinates"][j][1]===point[1]) {
                  //  console.log("vrau");
                  // console.log(routes[index]["geometry"]["coordinates"]);       
                         data.push(routes[index]["geometry"]["coordinates"]);
                }
                
            }
            
            
        }
return data;

    }
    
 // fonction pour retourne les route qui se touche a celle contenant le point de depart et le point d arrive
function routenodeAB(linkrouteA,linkrouteB) {
// console.log(linkrouteA)
//console.log(linkrouteB)
    var contentrouteA=linkrouteA;
    var contentrouteB=linkrouteB;
   let length1=contentrouteA.length;
   let length2=contentrouteB.length;
   
    var data =[];
    var length=length1<=length2?length1:length2;
    console.log(length1+ " " + length2+" ")
    
    for (let i = 0; i <length; i++) {
        console.log(i)
         
             /*
               let  test1=contentrouteA[i][0][0]===contentrouteB[j][0][0]&& contentrouteA[i][0][1]===contentrouteB[j][0][1];
           let test2=contentrouteA[i][0][0]===contentrouteB[j].pop()[0]&& contentrouteA[i][0][1]===contentrouteB[j].pop()[1]; 
         let test3=contentrouteA[i].pop()[0]===contentrouteB[j][0][0]&& contentrouteA[i].pop()[1]===contentrouteB[j][0][1]
           let test4=contentrouteA[i].pop()[0]===contentrouteB[j].pop()[0]&& contentrouteA[i].pop()[1]===contentrouteB[j].pop()[1];
        
             */
             for (let j = 0; j < length; j++) {
              //  console.log(contentrouteA[i][j])
            //    console.log(contentrouteA[i][j])
                if(contentrouteA[i][j][0][0]===contentrouteB[i][j][0][0]&& contentrouteA[i][j][0][1]===contentrouteB[i][j][0][1]){

                    data.push(contentrouteA[i][j] )
                    data.push( contentrouteB[i][j]);
                 }
                 if(contentrouteA[i][j][0][0]===contentrouteB[i][j][length2][0]&& contentrouteA[i][j][0][1]===contentrouteB[i][j][length2][1]){
                    data.push(contentrouteA[i][j] )
                    data.push( contentrouteB[i][j]);
                }
                 if(contentrouteA[i][j][length1][0]===contentrouteB[i][j][0][0] && contentrouteA[i][j][length1][1]===contentrouteB[i][j][0][1]){
                    data.push(contentrouteA[i][j] )
                    data.push( contentrouteB[i][j]);
                }
                if(contentrouteA[i][j][length1][0]===contentrouteB[i][j][length2][0] && contentrouteA[i][j][length1][1]===contentrouteB[i][j][length2][1]){
                    data.push(contentrouteA[i][j] )
                    data.push( contentrouteB[i][j]);
                }
                 
             }
         
        
    }
    return data;
}

    function routeContaint(point1,point2,routes){
       var data=[];
     //  console.log(routes);
       routes.forEach(route => {
        var i =0;
           route["geometry"]["coordinates"].forEach(point => {
              
               if(point[0]===point1[0]&& point[1]===point1[1]){
i=i+1;
               }
               if(point[0]===point2[0]&& point[1]===point2[1]){
                i=i+1;
                  }
                               
         });
         if(i===2){
            data.push(route);
           }

       });
    return data;

    }


    function isContaint(point1,point2,route){
        var iscontaint=false;
        
         if(route.includes(point1) && route.includes(point2)){
            iscontaint=true;
         }
        
     return iscontaint;
 
     }


     function  minRoute(routes){
         var res=[];
        for (let index = 0; index < routes.length-1; index++) {
          if(calculeDistantceRoute(routes[index])<calculeDistantceRoute(routes[index+1])){
              routes=routes[index];
          }
            
        }
return res;
     }

     function  truncateRoutesliste(point,route){ // divise le tabla  ux en deux
        var data=[];
        var data1=[];
        let index;
        fin=route.length;
        data=route.slice();
        //console.log(route)
        for (let i = 0; i < data.length; i++) {
            if(data[i][0]===point[0] && data[i][1]===point[1]){
                index=i;
          console.log("pos "+i)

                   }
         }
       // index===0?console.log():console.log(data.slice(0,index===0 ?index:index+1))
       // index===fin-1?console.log(): console.log(data.slice(index,fin-1))
     
        index===0?console.log():data1.push(data.slice(0,index+1))
        index===fin-1?console.log():data1.push(data.slice(index,fin))
     //  console.log(data)
 return data1;

}

     function truncateRoute(route,start,end){
    var data=[];
    data=route.slice();
   
        var debut=0,fin;

        
            for (let i = 0; i < data.length; i++) {
                if(data[i][0]===start[0] && data[i][1]===start[1]){
                    debut=i;
                 console.log(debut)
                 console.log(start)
                          }
                           if(data[i][0]===end[0] && data[i][1]===end[1]){
                    fin=i;
                    console.log(end)
                console.log(fin)

                       }

                
            }
            
            data={
                "type": "Feature",
                "name": "uy1-leclerc-cetic",
                "distance": calculeDistantceRoute(data.slice(debut<=fin?debut:fin,debut<=fin?fin+1:debut+1)),
                "properties": {},
                "geometry": {
                  "type": "LineString",
                  "coordinates":
            data.slice(debut<=fin?debut:fin,debut<=fin?fin+1:debut+1)}}
            
           // route[index]["distance"]=calculeDistantceRoute(route[index]);

       

    
   return data;
     }



   /* function  concat(route1,route2){
         console.log(route1);
var route =[]
route2.forEach(route => {

  route = route1.push(route);

     });
    
     return route;
    }*/
     function direction(start,end){
         var nroad=[];
         var Routes= roads["features"];
         nroad= routeContaint(start,end,Routes)
         console.log(nroad.length);
         switch (nroad.length) {
             case 0:
                var nroad1=[];
              nroad1=routeContaint1(start,end,Routes);
              switch (nroad1.length) {
                  case 0:
                      
                      break;
              
                  default:
                     
                      let routecontentA=[];
                      let routecontentB=[];
                      let routelinkA=[];
                      let routelinkB=[];
                      let linkrout=[];
                     let truncRouteA=[];
                     let truncRouteB=[];
                     let joinA=[];
                     let joinB=[];
                     let routenodesAB=[];
                     let routefinal=[];

                      
                     routecontentB=routecontents(end,roads["features"].slice()).filter( (route)=>{
                        return route;
                    } );
                    routecontentA=routecontents(start,roads["features"].slice()).filter( (route)=>{
                        return route;
                    } );
                    
                    routecontents(start,roads["features"].slice()).slice().forEach(route => {
                        routelinkA.push(routeEnCommun(route.slice()).slice());
                    });
                    routecontents(end,roads["features"].slice()).slice().forEach(route => {
                        routelinkB.push(routeEnCommun(route.slice()).slice());
                    });
                  var trunrouteA1=[];
                   var d= routecontents(start,roads["features"].slice()).slice();
                    for (let index = 0; index < d.length; index++) {
                       truncRouteA.push(...truncateRoutesliste(start.slice(),d[index].slice()).slice())
                       trunrouteA1.push(...truncateRoutesliste(start.slice(),d[index].slice()).slice())

                    }
                    var trunrouteB1=[];
                   var d1= routecontents(end,roads["features"].slice()).slice();
                    for (let index = 0; index < d1.length; index++) {
                       truncRouteB.push(...truncateRoutesliste(end.slice(),d1[index].slice()).slice())
                       trunrouteB1.push(...truncateRoutesliste(end.slice(),d1[index].slice()).slice())

                    }
                   routenodesAB=routenodeAB(routelinkA.slice(),routelinkB.slice()).slice();
                
                 let joinA1= linkRoute(routenodesAB.slice(),trunrouteA1.slice()).slice();
                 
                  joinA=linkRoute(routenodesAB.slice(),trunrouteA1.slice()).slice();
              joinB=linkRoute(joinA1,trunrouteB1.slice()).slice();
              joinB.forEach(route => {
               routefinal.push( truncateRoute(route.slice(),start,end));
              });
                  console.log(routefinal)
               //   console.log(routenodesAB)

                  /*  routecontents(end,roads["features"].slice()).slice().forEach(route => {
                        routelinkB.push(routeEnCommun(route.slice()).slice());
                    });*/

                   
                   
 
nroad ={
  //"routecontentA":routecontentA,
    //"routecontentB":routecontentB,
 //  "routelinkA":routelinkA,
//"routelinkB":routelinkB,
 // "truncroute A":truncRouteA,
   // "truncroute B":truncRouteB,
 // "routenodeAB":routenodesAB
 "route":routefinal
}




                   

                   
                
              

                      break;
              }

              return nroad ;
                 
                 break;

             case 1:
                    
               return truncateRoute(nroad[0]["geometry"]["coordinates"],start,end);
                
                    break;
                        
             default:
                console.log(nroad.length);
                 return minRoute(nroad)
                 break;
         }





     }
    
 

    
    module.exports ={
        calculeDistantce,calculeDistantceRoute,direction
    }