import 'package:flutter/material.dart';


class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  List<String> items = ["oi1","oi2","oi3","oi4","oi5","oi6",];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Notificações (${items.length})"),
        centerTitle: true,
      ),
      body: new ListView.builder(

          itemCount: items.length,
          itemBuilder: (context,index){

        final item = items[index];

        return Dismissible(
          key: Key(item),
          direction: DismissDirection.endToStart,

          onDismissed: (direction){

            setState(() {
              items.removeAt(index);
            });

          },
          background: new Container(
            color: Colors.red,
            child: new Stack(children: <Widget>[
              new Positioned(child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Icon(Icons.delete,size: 35.0,),
              ),right: 0.0,top: 0.0,bottom: 0.0,)
            ],),
          ),


          child: Column(
            children: <Widget>[
              new ListTile(
                trailing: new Column(children: <Widget>[

                  new Text("12:45"),
                  new Icon(Icons.notifications,color: Colors.amber,)

                ],),
                title: new Text("Burguer King"),
                subtitle: new Text("Seu pedido saiu para entrega"),

              ),
              new Divider()
            ],
          ),
        );


      }),
    );
  }
}
