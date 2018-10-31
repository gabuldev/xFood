import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xfood/pages/produto_page.dart';
import 'package:xfood/pages/carrinho_page.dart';
import 'package:xfood/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RestPage extends StatefulWidget {
  String title;
  Bloc bloc = Bloc();
  RestPage({this.title});
  @override
  _RestPageState createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {
  List<String> empresa = [];

  //STREAM
  var listCategoriasProd = BehaviorSubject<List<Widget>>();





  @override
  void initState() {
    empresa = ["Gabul Lanches", "Burguer King", "Lonas", "Lonas", "Lonas"];
    super.initState();
  }

  @override
  void dispose() {
    empresaselecionada.sink.add(null);
    meupedido.sink.add(Pedido(listprodutos: List()));
    super.dispose();
  }



  Future<bool> _onWillPop() async{
    if(meupedido.value.listprodutos.length > 0){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Atenção"),
        content:   new Text("Se sair seus itens do carrinho serão apagados. Tudo bem?"),
        actions: <Widget>[
          FlatButton(onPressed: ()=> Navigator.pop(context,false), child: new Text("Não")),
          FlatButton(onPressed: ()=> Navigator.pop(context,true), child: new Text("Sim")),
        ],
      )
    );}
    else
      return true;

  }


  @override
  Widget build(BuildContext context) {

    void criarLayoutProdutos(){

      List lista = widget.bloc.criarProdutos();
      List<Widget> listwidget = [];
      Widget listview;
      for(int i =0;i<lista.length;i++) {
        print(lista[i].length);
        listview = new ListView.builder(
            itemCount: lista[i].length,
            itemBuilder: (BuildContext context, int index) {
              return new Padding(
                  padding: EdgeInsets.all(5.0),
                  child: DecoratedBox(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0)),
                      child: new ListTile(
                        onTap: () {
                          produtoselecionado.sink.add(lista[i][index]);
                          print(produtoselecionado.value.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new ProdutoPage()));
                        },
                        title: new Text(lista[i][index].nome),
                        leading: CircleAvatar(
                          maxRadius: 10.0,
                          backgroundColor: Colors.green,
                        ),
                        trailing: new Text("R\$: ${lista[i][index].preco}"),
                      )));
            });

        listwidget.add(listview);

      }

      listCategoriasProd.add(listwidget);
    }

    return new Scaffold(
        backgroundColor: Colors.yellow,
        body: new StreamBuilder(

            stream:empresaselecionada.stream ,
            builder: (context,snapshot){

              if(snapshot.hasData)
                criarLayoutProdutos();

          return  snapshot.hasData ? WillPopScope(
            onWillPop: _onWillPop,
            child: new DefaultTabController(
              length: snapshot.data.cardapio.categorias.length,
              child: new NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.green,
                        expandedHeight: 200.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Image.network(
                              "https://pbs.twimg.com/profile_images/1014518786672611328/UN8f_zcS_400x400.jpg",
                              fit: BoxFit.cover,
                            )),
                      ),
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(new TabBar(
                            indicator: ShapeDecoration.fromBoxDecoration(
                                BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50.0))),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: widget.bloc.criartabs())),
                        pinned: true,
                      ),
                    ];
                  },
                  body: new StreamBuilder(
                      stream: listCategoriasProd.stream,
                      builder: (context,snapshot){
                      return snapshot.hasData?  new TabBarView(children : snapshot.data) : new CircularProgressIndicator();
                  })
              )
            ),
          ): new Center(child: new CircularProgressIndicator(),);

            }),
        floatingActionButton: //new FloatingActionButton(onPressed: (){},child: new Icon(Icons.shopping_cart),),
        new FloatingActionButton.extended(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new CarrinhoPage()));
        }, icon: new CircleAvatar(child: new Icon(Icons.shopping_cart),), 
          
          label:new StreamBuilder(
              stream: meupedido,
              builder: (BuildContext context, AsyncSnapshot snapshot){

                return snapshot.hasData && snapshot.data.listprodutos.length > 0 ? new Text("R\$: ${snapshot.data.valorTotal()}") : new Text("Escolha algum produto");

              })
          
          
          ,backgroundColor: Colors.grey,),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Padding(
        padding: EdgeInsets.all(5.0),
        child: new DecoratedBox(
            decoration: new BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
            child: _tabBar));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
