import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String resultado = "EM ESPERA";

  TextEditingController txtcep = TextEditingController();

  void buscacep() async {
    String cep = txtcep.text;
    String url = "https://brasilapi.com.br/api/cep/v1/$cep/";
    http.Response response;
    response = await http.get(url);

    Map<String, dynamic> dados = json.decode(response.body);

    String cepData = dados["cep"];
    String stateData = dados["state"];
    String cityData = dados["city"];
    String neighborhoodData = dados["neighborhood"];
    String streetData = dados["street"];

    String data = """
    CEP: $cepData
    Estado: $stateData
    Cidade: $cityData
    Vizinhança: $neighborhoodData
    Rua: $streetData
    """;

    setState(() {
      resultado = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LocApp CEP"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: txtcep,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "05010000",
                  labelText: "CEP",
                ),
                style: TextStyle(fontSize: 16),
              ),
              RaisedButton(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Text("Consultar"),
                onPressed: buscacep,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)
                ),
              ),
              Text(resultado)
            ],
          ),
        ),
      ),
    );
  }
}