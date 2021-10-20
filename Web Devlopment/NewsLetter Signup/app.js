const express=require("express");
const https=require("https");
const bodyParser=require("body-parser");
const request=require("request");
const app=express();
app.use(bodyParser.urlencoded({extended:true}));
app.use(express.static("public")); 
app.get("/",function(req,res){
        res.sendFile(__dirname+"/signup.html")
});


app.post("/",function(req,res){
      const data={
              members: [
                  {
                      email_address :req.body.email,
                      status : "subscribed",
                      merge_fields : {
                            FNAME : req.body.first,
                            LNAME : req.body.second
                      }
                                      }
              ]
      }

      const jsondata=JSON.stringify(data);
       
      const url= "https://us6.api.mailchimp.com/3.0/lists/5031a3432e";

      const options={
             method: "POST",
             auth: "sudhankar1:d15f292a358580e3f6809bdc947c1982-us6"
      }

      const request=https.request(url,options,function(response){
             
        if(response.statusCode===200){
            res.sendFile(__dirname+"/success.html");
        }else {
            res.sendFile(__dirname+"/failure.html");
        }

               response.on("data",function(data){
                   //console.log(JSON.parse(data));
               })
      })

      request.write(jsondata);
      request.end();
});

app.post("/failure",function(req,res){
    res.redirect("/");
});

app.listen(process.env.PORT || 3000,function(){
    console.log("server running on port 3000");
});


      