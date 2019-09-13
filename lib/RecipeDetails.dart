import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'RecipeWidget.dart';


class RecipeDetails extends StatefulWidget{
  @override

  var uuid;

  var rec;

  RecipeDetails(id){
    this.uuid = id;
  }



  setUUID(id){
    uuid = id;
  }

  State<StatefulWidget> createState() {
    return RecipeDetailsState();
  }
}

class RecipeDetailsState extends State<RecipeDetails> {

  var isLoading = true;
  final url = "https://test.kode-t.ru/recipes/";

  var needToLoad = true;

  fetchData() async{
    print("trying fetch data");

    final fullUrl = url + widget.uuid;
    print("fullurl");
    print(fullUrl);
    final response = await http.get(fullUrl);
    print(response);
    if(response.statusCode == 200){
      print("HTTP OK");
      final map = json.decode(response.body);
      final jsonRecipe = map["recipe"];

      setState(() {
        needToLoad = false;
        isLoading = false;
        widget.rec = jsonRecipe;
      });
    }
    if(response.statusCode == 404){
      print("HTTP NOT FOUND");
    }
  }

  body(){
    final description = widget.rec["description"];
    final name = widget.rec["name"];
    final instr = widget.rec["instructions"];
    final images = widget.rec["images"];
    return Column(
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
          ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    if(needToLoad){
      fetchData();
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("name"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffb74093),
                borderRadius: BorderRadius.circular(20),
              ),
              child: isLoading ? new CircularProgressIndicator() : body()
          ),
        ),
    );
  }


}
