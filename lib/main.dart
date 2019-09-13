import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

void main() => runApp(RealApp());


class RealApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return new RealAppState();
  }
}


class RealAppState extends State<RealApp>{

  var isLoading = false;
  final url = "https://test.kode-t.ru/recipes";

  var recipes;

  fetchData() async{
    print("trying fetch data");
    
    final response = await http.get(url);
    print(response);

    if(response.statusCode == 200){
      print("HTTP OK");

      final map = json.decode(response.body);
      final jsonRecipes = map["recipes"];


     /* recipes.forEach((recipe){
        print(recipe["name"]);
      });
      */
      setState(() {

        isLoading = false;
        this.recipes = jsonRecipes;
      });
    }

    if(response.statusCode == 404){
      print("HTTP NOT FOUND");
    }

  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("realy cool app"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.refresh), onPressed: (){
              print("Reloading");
              setState(() {
                isLoading = true;
              });
              fetchData();
            })
          ],
        ),
        body: new Center(
          child: isLoading ? new CircularProgressIndicator() : new ListView.builder(
              itemCount: this.recipes != null ? this.recipes.length : 0,
              itemBuilder: (context , i){
                return new FlatButton(onPressed: (){
                    Navigator.push(context,new MaterialPageRoute(
                        builder:(context) => new RecipeDetails(recipes[i]))
                    );
                }, child: new RecipeWidget(recipes[i]));
              }

          ),
        )
      ),
    );
  }
}

class RecipeWidget extends StatelessWidget{

  final recipe;

  RecipeWidget(this.recipe);

  @override
  Widget build(BuildContext context) {

    final description = recipe["description"];
    final name = recipe["name"];

    return new Container(
        margin: new EdgeInsets.all(20),
        decoration: new BoxDecoration(
          color: Colors.green,
          borderRadius: new BorderRadius.circular(40),

        ),

        child: new Column(
          children: <Widget>[
            new Divider(),
            new Image.network(recipe["images"][0]),
            new Container(
              padding: new EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Text(name,style: new TextStyle(fontSize: 16.0),
                  ),
                  new Text(description != null ? description : " ")
                ],
              ),
            ),

          ],
        )
    );
  }
}

class RecipeDetails extends StatelessWidget{

  final recipe;

  RecipeDetails(this.recipe);


  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(recipe["name"]),
        ),
       body: new RecipeWidget(recipe) ,
      );
  }

}