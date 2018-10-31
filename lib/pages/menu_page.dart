import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: new AppBar(backgroundColor: Colors.green,),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          new Center(
            child: new Column(
              children: <Widget>[
           new Container(
            width: 180.0,
            height: 180.0,
            decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/5/57/Who_is_it.png"))
            ),
          ),
                new Text("Seu nome",textScaleFactor: 1.5,)
                
              ],
            ),
          ),


          Container(color: Colors.white,child: new ListTile(title: new Text("Pedidos"),trailing: new Icon(Icons.navigate_next),)),

          Container(color: Colors.white,child: new ListTile(title: new Text("Endereços"),trailing: new Icon(Icons.navigate_next),)),

          Container(color: Colors.white,child: new ListTile(title: new Text("Trocar senha"),trailing: new Icon(Icons.navigate_next),)),

          Container(color: Colors.white,child: new ListTile(title: new Text("Sugestões"),trailing: new Icon(Icons.navigate_next),)),

          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(color: Colors.white,child: new ListTile(title: new Text("Sair"),trailing: new Icon(Icons.exit_to_app),)),
          ),
          
        ],
      ),
      bottomNavigationBar: new FlatButton(onPressed: (){

        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) => const _DemoDrawer(),
        );

      }, child: new Text("Desenvolvido por Grape Dev")) ,
    );
  }
}


class _DemoDrawer extends StatelessWidget {
  const _DemoDrawer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          
          new FlatButton(onPressed: (){},  child: new Text("Clique aqui para entrar em contato")),
          new FlatButton(onPressed: (){},  child: new Text("Facebook"))
        ],
      ),
    );
  }
}