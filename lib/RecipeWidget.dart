import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class RecipeWidget extends StatelessWidget {
  final recipe;

  RecipeWidget(this.recipe);

  @override
  Widget build(BuildContext context) {
    final description = recipe["description"];
    final name = recipe["name"];

    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xffb74093),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Divider(),
            Image.network(recipe["images"][0]),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(description != null ? description : " "),
                ],
              ),
            ),
          ],
        ));
  }
}
