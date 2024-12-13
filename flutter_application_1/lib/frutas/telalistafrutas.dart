import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/frutas/teladetalhesfrutas.dart';
import 'package:http/http.dart' as http;
import '../model/frutas.dart';

class Telalistafrutas extends  StatefulWidget {
  const Telalistafrutas({super.key});

  @override
  State<Telalistafrutas> createState() => _TelalistafrutasState();
}

class _TelalistafrutasState extends State<Telalistafrutas> {
  bool isLoading = false;
  ScrollController positionController = ScrollController();
  int page = 1;
  int maxPage = 999;
  List<Frutas> allFruits = [];

  Future<List<Frutas>> fetchSagas(int page) async{
    if(!isLoading && page <= maxPage){
      isLoading = true;

      final response = await http.Client().get(Uri.parse("https://api.api-onepiece.com/v2/fruits/en?page=$page"));

      if (response.statusCode == 200){
        var dataResult = json.decode(response.body);

        dataResult.forEach((fruta){
          try{
             Frutas fruta1 = Frutas(
            id: fruta['id'],
            name: fruta['name'],
            roman_name: fruta['roman_name'],
            type: fruta['type'],
            description: fruta['description'],
            filename: fruta['filename'],
            technicalFile: fruta['technicalFile'],
          );
          allFruits.add(fruta1);
          }catch(e){
            print(e);
          }
         
        });
        page++;
        isLoading = false;
      }else{
        debugPrint("Erro na conexão");
        return[];
      }
    }
    return allFruits;
  }

  @override
  Widget build(BuildContext context){
    positionController.addListener((){
      if(positionController.position.pixels >= positionController.position.maxScrollExtent * 0.7){
        setState(() {
          fetchSagas(page);
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de de Frutas"),
      ), 
      body: FutureBuilder(future: fetchSagas(page), 
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }else{
          List<Frutas> listaFrutas = snapshot.data as List<Frutas>;
          return ListView.builder(
            controller: positionController,
                itemCount: listaFrutas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Teladetalhesfrutas(
                      fruta1: listaFrutas[index]
                    ),)),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(listaFrutas[index].filename)),
                          title: Text(listaFrutas[index].name),
                          subtitle: Text(listaFrutas[index].roman_name),
                        ),
                      ),
                    );
                },
            // controller: positionController,
            // itemCount: listaFrutas.length,
            // itemBuilder: (context, index){
            //   return Card(
            //     margin: EdgeInsets.all(8.0),
            //     child: ListTile(
            //       title: Text(listaFrutas[index].name),
            //       subtitle: Text("Nome romano:  ${listaFrutas[index].roman_name}"),
            //       leading: Icon(Icons.location_on),
            //     ),
            //   );
            // },
            
            );
        }
      }),
    );
  }
}