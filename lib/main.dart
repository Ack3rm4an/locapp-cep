import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String resultado = "";

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
      bottomNavigationBar: Stack(
        children: [
          new Container(
            height: 100.0,
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 20.0,
            child: new RaisedButton(
                child: Text("Consultar"),
                onPressed: buscacep,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.blue),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                maxLength: 8,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                ],
                controller: txtcep,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "05010000",
                  labelText: "CEP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                ),
                style: TextStyle(fontSize: 16),
              ),
              Padding(padding: EdgeInsets.all(85)),
              Text(resultado)
            ],
          ),
        ),
      ),
    );
  }
}
