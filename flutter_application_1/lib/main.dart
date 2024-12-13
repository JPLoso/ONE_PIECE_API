import 'package:flutter/material.dart';
import 'package:flutter_application_1/frutas/TelaListaFrutas.dart';
import 'package:flutter_application_1/personagens/TelaListaPersonagens.dart';
import 'package:flutter_application_1/sagas/TelaListaSagas.dart';
//import 'package:flutter_application_1/sagas/TelaListaSagas.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Aplicativo da One_Piece_API",
    home: Home(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}

class Home extends StatelessWidget{
    const Home({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplicativo da One_Piece_API"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Telalistafrutas()));
              },
              child: Column(
                children: [
                  Image.asset("images/frutas.png", width: 120, height: 120,),
                  const Text("Frutas", style: TextStyle(fontSize: 48),)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Telalistasagas()));
              },
              child: Column(
                children: [
                  Image.asset("images/sagas.png", width: 120, height: 120,),
                  const Text("Sagas", style: TextStyle(fontSize: 48),)
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Telalistapersonagens()));
              },
              child: Column(children: [
                Image.asset("images/personagens.png", width: 120, height: 120,),
                const Text("Personagens", style: TextStyle(fontSize: 48),)
              ],)
            )
          ],
        ),
      ),
    );
  }
}