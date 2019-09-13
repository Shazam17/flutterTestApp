import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'RecipeWidget.dart';


class RecipeDetails extends StatefulWidget{
  @override

  var rec;
  var uuid;

  RecipeDetail(rec){
    this.rec = rec;
  }

  setRecipe(recipe){
    rec = recipe;
  }
  setUUID(id){
    uuid = id;
  }

  State<StatefulWidget> createState() {
    // TODO: implement createState
    var state = RecipeDetailsState();
    state.setRecipe(rec);
    return state;
  }
}

class RecipeDetailsState extends State<RecipeDetails> {
  var recipe;

  setRecipe(rec){
    this.recipe =rec;
  }

  @override
  Widget build(BuildContext context) {
    final description = recipe["description"];
    final name = recipe["name"];
    final instr = recipe["instructions"];
    final images = recipe["images"];

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(recipe["name"]),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffb74093),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, position) {
                          return Image.network(images[position]);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Column(children: <Widget>[
                      Text(name),
                      Text(description != null ? description : " "),
                      Text(instr != null ? instr : " "),
                    ]),
                  )
                ],
              )),
        ));
  }
}
