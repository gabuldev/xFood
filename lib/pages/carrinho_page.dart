import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xfood/pages/carrinho/pedidos_page.dart';
import 'package:xfood/pages/carrinho/entrega_page.dart';
import 'package:xfood/pages/carrinho/pagamento_page.dart';
import 'package:rxdart/rxdart.dart';


class CarrinhoPage extends StatefulWidget {
  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {


  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new NestedScrollView(
            headerSliverBuilder:
                (BuildContext context2, bool innerBoxScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.green,
                  expandedHeight: 200.0,
                  floating: false,
                  snap: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      title: new Text("Verifique seu pedido"),
                      centerTitle: true,
                      background: Image.network(
                        "https://cdn.logojoy.com/wp-content/uploads/2017/07/McDonalds_logo_red_America_USA.png",
                        fit: BoxFit.fill,
                      )),
                ),
              ];
            },
            body: PedidosPage(),),
        bottomNavigationBar:
            new BottomNavigationBar(fixedColor: Colors.green, items: [
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.close,
              color: Colors.grey,
            ),
            title: new Text(
              "Cancelar",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          new BottomNavigationBarItem(
              icon: new CircleAvatar(
                  backgroundColor: Colors.green,
                  child: new Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )),
              title: new Text(
                "Avancar",
                style: TextStyle(color: Colors.green),
              ),
              backgroundColor: Colors.green),
        ]));
  }
}
