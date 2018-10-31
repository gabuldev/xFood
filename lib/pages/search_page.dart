import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xfood/bloc/bloc.dart';
import 'package:xfood/pages/restaurante_page.dart';
import 'package:rxdart/rxdart.dart';

class SearchPage extends StatefulWidget {
  Bloc bloc = Bloc();



  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {



  var empresaEncontrada = BehaviorSubject<List<dynamic>>();

  void search(String value){

    List<dynamic> lista = [];

    for(var item in empresas.value){

      if(item.nome.toLowerCase().contains(value)){
        lista.add(item);
      }

    }

    empresaEncontrada.add(lista);






  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.yellow,
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new TextField(
          onChanged: (String value) => search(value),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Pesquise...",
            hintStyle: TextStyle(color: Colors.white)
          ),
        ),
      ),
      body: new StreamBuilder(

          stream: empresaEncontrada.stream,
          builder: (context,snapshot){
       return snapshot.hasData ? snapshot.data.length > 0 ? new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
          return new Padding(
              padding: EdgeInsets.all(5.0),
              child: DecoratedBox(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: new ListTile(
                    enabled: true /*widget.bloc.verificaAbertoBool(horaAberto:snapshot.data[index].horaAberto,horaFechado: snapshot.data[index].horaFechado)*/,
                    onTap: (){

                      widget.bloc.loadingEmpresa(index);//VERIFICAR MELHOR ESSA LOGICA

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RestPage(title:snapshot.data[index].nome)));

                    },
                    isThreeLine: true,
                    title: new Text(snapshot.data[index].nome),
                    leading: Image(image: NetworkImage(snapshot.data[index].logo),width: 50.0,height: 50.0,color: widget.bloc.verificaAbertoBool(horaAberto:snapshot.data[index].horaAberto,horaFechado: snapshot.data[index].horaFechado) ? null : Colors.grey,),
                    trailing: new IconButton(
                        icon: new Icon(
                          Icons.favorite_border,
                          color: widget.bloc.verificaAbertoBool(horaAberto:snapshot.data[index].horaAberto,horaFechado: snapshot.data[index].horaFechado) ?  Colors.red : Colors.grey,
                        ),
                        onPressed: null),
                    subtitle: new Text(
                        "${widget.bloc.verificaAberto(horaAberto: snapshot.data[index].horaAberto,horaFechado: snapshot.data[index].horaFechado)}\nFuncionamento: ${snapshot.data[index].horaAberto} às ${snapshot.data[index].horaFechado} "),
                  )));
        }): new Column(children: <Widget>[
              
            new Center(child: new Text("Nenhuma empresa encontrada",style: Theme.of(context).textTheme.title,),),
         new Center(child: new FlatButton(onPressed: (){}, child: new Text("Sugestões? Nos envie cliclando aqui")),)
          
       ],) : new Center(child: new CircularProgressIndicator(),);

      }) ,
    );
  }
}
