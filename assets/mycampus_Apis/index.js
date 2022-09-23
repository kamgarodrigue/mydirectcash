
const express           = require("express")
const mongoose          = require("mongoose")
const morgan            = require("morgan")
const bodyParser        = require("body-parser")  
const AuthRoute         = require("./Routes/Auth")
const partenaireRoute         = require("./Routes/partenaire")
const autoriteRoute         = require("./Routes/autorite")
const favorieplace         = require("./Routes/favorieplace")
const lieu        = require("./Routes/lieu")
const campus      = require("./Routes/Campus")
const commande          = require("./Routes/commande")
 const service          = require("./Routes/service")
 const pub          = require("./Routes/pub")
 const route          = require("./Routes/Route")
 const typeLieu          = require("./Routes/typeLieu")
 const boutique         = require("./Routes/boutique")
 const categorisPub         = require("./Routes/Categorispub")
 const Sig        = require("./Routes/Sig")



//'mongodb://localhost:27017/foodApp'
//'mongodb://localhost:27017/mycampus'
//'mongodb+srv://Kamga:2001@mycampus.1iir2.mongodb.net/myFirstDatabase?retryWrites=true&w=majority'
const uri1 = 'mongodb+srv://Kamga:2001@mycampus.1iir2.mongodb.net/myFirstDatabase?retryWrites=true&w=majority';
mongoose.set('useCreateIndex', true)
mongoose.connect('mongodb://localhost:27017/mycampus',{useNewUrlParser:true,useUnifiedTopology:true})
.then(() => console.log('Connexion à MongoDB réussie !'))
.catch((err) => console.log(err ));
const db = mongoose.connection
const app= express()
app.use(morgan('dev'))
app.use(bodyParser.urlencoded({extended:false}))
app.use(bodyParser.json())

app.use('/upload',express.static('upload'))
const port = process.env.port || 5000
app.listen(port,()=>{

});
app.use('/api/users',AuthRoute);
app.use('/api/partenaire',partenaireRoute);
app.use('/api/autorite',autoriteRoute);
app.use('/api/favorieplace',favorieplace);
app.use('/api/campus',campus);
app.use('/api/lieu',lieu);
app.use('/api/commande',commande);
app.use('/api/service',service);
app.use('/api/pub',pub);
app.use('/api/polyline',route);
app.use('/api/typeLieu',typeLieu);
app.use('/api/boutique',boutique);
app.use('/api/categorisPub',categorisPub);
app.use('/api/sig',Sig);
// https://shielded-falls-07947.herokuapp.com/heroku local web