const inshorts= require('inshorts-api');

var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000;

app.get("/",function(req, res){
    res.send("<h1>Hi there</h1>")
})
  
  app.get("/:id/news",function(req, res){
    var cat = req.params.id;   
    console.log(cat);
    var options = {
      lang: 'en',
      category: cat,
      numOfResults: 5
    }
    inshorts.get(options, function(result){
      console.log(result);
      res.send(result);
    });
      
})


app.listen(port);