// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=4ac6b704";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('\$ Conversor \$'),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text("Carregando dados...",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                          textAlign: TextAlign.center));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text("Erro ao carregar dados :(",
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                            textAlign: TextAlign.center));
                  } else {
                    // dolar =
                    //     snapshot.data["results"]["currencies"]["USD"]["buy"];
                    // euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.amber),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Reais",
                                labelStyle: TextStyle(color: Colors.amber),
                                prefixText: "R\$"),
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                          )
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(
      'https://api.hgbrasil.com/finance?format=json-cors&key=4ac6b704'));
  return json.decode(response.body);
}
