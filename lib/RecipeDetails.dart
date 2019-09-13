import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'RecipeWidget.dart';

class RecipeDetails extends StatelessWidget {
  final recipe;

  RecipeDetails(this.recipe);

  @override
  Widget build(BuildContext context) {
    final description = recipe["description"];
    final name = recipe["name"];
    final images = recipe["images"];
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(recipe["name"]),
      ),
      body: Container(
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
            child: Column(
              children: <Widget>[
                Text(name),
                Text(description != null ? description : " ")],
            ),
          )
        ],
      )),
    );
  }
}
