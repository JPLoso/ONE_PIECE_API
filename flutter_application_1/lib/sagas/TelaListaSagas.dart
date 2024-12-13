import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/sagas.dart';

class Telalistasagas extends  StatefulWidget {
  const Telalistasagas({super.key});

  @override
  State<Telalistasagas> createState() => _TelalistasagasState();
}

class _TelalistasagasState extends State<Telalistasagas> {
  bool isLoading = false;
  ScrollController positionController = ScrollController();
  int page = 1;
  int maxPage = 999;
  List<Sagas> allSagas = [];

  Future<List<Sagas>> fetchSagas(int page) async{
    if(!isLoading && page <= maxPage){
      isLoading = true;

      final response = await http.Client().get(Uri.parse("https://api.api-onepiece.com/v2/sagas/en?page=$page"));

      if (response.statusCode == 200){
        var dataResult = json.decode(response.body);

        dataResult.forEach((saga){
          try{
             Sagas saga1 = Sagas(
            id: saga['id'],
            tittle: saga['title'],
            saga_number: saga['saga_number'],
            saga_chapitre: saga['saga_chapitre'],
            saga_volume: saga['saga_volume'],
            saga_episode: saga['saga_episode'],
          );
          allSagas.add(saga1);
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
    return allSagas;
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
        title: Text("Lista de Sagas"),
      ),
      body: FutureBuilder(future: fetchSagas(page), 
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }else{
          List<Sagas> listaSagas = snapshot.data as List<Sagas>;
          return ListView.builder(
            controller: positionController,
            itemCount: listaSagas.length,
            itemBuilder: (context, index){
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(listaSagas[index].tittle),
                  subtitle: Text("Numero da saga: ${listaSagas[index].saga_number}/Episodios: ${listaSagas[index].saga_episode}"),
                  leading: Icon(Icons.location_on),
                ),
              );
            },);
        }
      }),
    );
  }
}