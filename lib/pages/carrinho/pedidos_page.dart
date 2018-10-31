import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xfood/bloc/bloc.dart';

class PedidosPage extends StatefulWidget {
  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {


  Future<Null> alertDescricao(String obs) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sua Observação'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new TextFormField(
                  initialValue: obs,
                  decoration: new InputDecoration(
                    labelText: "Mensagem",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(

        stream: meupedido.stream,
        builder: (context,snapshot){
     return snapshot.hasData?  new ListView.builder(
          itemCount: snapshot.data.listprodutos.length,
          itemBuilder: (BuildContext context, int index) {
            final item = snapshot.data.listprodutos[index];
            return new Dismissible(
                key: Key(item.nome),
                direction: DismissDirection.endToStart,
                onDismissed: (direction){

                  print(direction.index);
                  setState(() {
                    snapshot.data.listprodutos.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(content: new Text("Item removido!"),action: SnackBarAction(label: "Voltar", onPressed: (){
                    setState(() {
                      snapshot.data.listprodutos.add(item);
                    });
                  }),));
                },
                background: new Container(color: Colors.red,child: new Stack(children: <Widget>[new Positioned(child: new Icon(Icons.delete,color: Colors.white,size: 50.0,),right: 12.0,top: 0.0,bottom: 0.0,),],)),
                child: new Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: new ListTile(
                    title: new Text(snapshot.data.listprodutos[index].nome),
                    leading: new Text("QTD: ${snapshot.data.listprodutos[index].qtd}"),
                    subtitle:
                    snapshot.data.listprodutos[index].qtd > 1 ?
                    new Text("Unidade: R\$ ${snapshot.data.listprodutos[index].preco} \nTotal R\$ ${snapshot.data.listprodutos[index].preco*snapshot.data.listprodutos[index].qtd}") :
                    new Text("Unidade: R\$ ${snapshot.data.listprodutos[index].preco}"),
                    trailing: new IconButton(
                        icon: new Icon(Icons.info), onPressed: () {

                          if(snapshot.data.listprodutos[index].obs.toString().length > 0){
                            alertDescricao(snapshot.data.listprodutos[index].obs);
                          }
                      else {
                            //VERIFICA SE TEM OBS, SE FOR FALSO EXIBE ESSE SNACKBAR
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: new Text(
                                    "Esse item não contém observações"),
                                action: SnackBarAction(
                                    label: "Adicionar?", onPressed: () {
                                  alertDescricao("Sem observações");
                                })));
                          }

                    }),
                  ),
                ));
          }) : new Center(child: new Text("Carrinho vazio"),);
    });
  }
}
