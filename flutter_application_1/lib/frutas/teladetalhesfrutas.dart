import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/table_row.dart';
import '../model/frutas.dart';

// ignore: must_be_immutable
class Teladetalhesfrutas extends StatelessWidget{
  Frutas fruta1;
  Teladetalhesfrutas({required this.fruta1});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Detalhes da Fruta " + fruta1.name),
    ),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(fruta1.filename),
            radius: 125.0,

          ),
        ),
        TableRowDetails(title: "Nome: ", value: fruta1.name,),
        TableRowDetails(title: "Nome Romano: ", value: fruta1.roman_name,),
        TableRowDetails(title: "Tipo: ", value: fruta1.type,),
        TableRowDetails(title: "Descrição", value: fruta1.description,),
      ],
    ),
    );
  }
}