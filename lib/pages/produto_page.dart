import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xfood/bloc/bloc.dart';

class ProdutoPage extends StatefulWidget {
  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  var controller = TextEditingController();

  //STREAM PARA OUVIR A QUANTIDADE
  var quantidade = BehaviorSubject<int>(seedValue: 1);

  @override
  void dispose() {
    quantidade.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.yellow,
      body: DefaultTabController(
        length: 2,
        child: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.green,
                expandedHeight: 200.0,
                floating: false,
                snap: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Image.network(
                      "https://guiadacozinha.com.br/wp-content/uploads/2018/06/hamburguer-mexicano.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(new TabBar(
                    indicator: ShapeDecoration.fromBoxDecoration(BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50.0))),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: new Text("Ingredientes"),
                      ),
                      Tab(
                        child: new Text("Adicionais"),
                      ),
                    ])),
                pinned: true,
              ),
            ];
          },
          body: StreamBuilder(
              stream: produtoselecionado.stream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? new TabBarView(children: [
                        new ListView.builder(
                            itemCount: snapshot.data.descricao.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 50.0,
                                    right: 50.0),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: new ListTile(
                                    trailing: new CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: new IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: (){
                                            var produto = snapshot.data;
                                            var deletado = snapshot.data;

                                            produto.descricao
                                                .removeAt(index);

                                            produtoselecionado.sink
                                                .add(produto);

                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: new Text(
                                                  "Ingrediente removido!"),
                                              action: SnackBarAction(
                                                  label: "Voltar", onPressed: (){
                                                produtoselecionado.sink
                                                    .add(deletado);

                                              }),
                                            ));
                                          }),
                                    ),
                                    title: Center(
                                        child: Text(snapshot
                                            .data.descricao[index]
                                            .toLowerCase())),
                                  ),
                                ),
                              );
                            }),
                        new ListView.builder(itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 50.0, right: 50.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: new ListTile(
                                subtitle: new Text("+ 200g"),
                                leading: new CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: new IconButton(
                                      icon: Icon(Icons.add), onPressed: () {}),
                                ),
                                trailing: new Text("R\$: 2.50"),
                                title: Text("Alface"),
                              ),
                            ),
                          );
                        }),
                      ])
                    : new Center(
                        child: new CircularProgressIndicator(),
                      );
              }), /* new ListView(
            padding: new EdgeInsets.all(5.0),
            children: <Widget>[

              new StreamBuilder(
                  stream: produtoselecionado.stream,
                  builder: (context,snapshot){

                    return snapshot.hasData ? Center(child: new Text(snapshot.data.nome,style: TextStyle(fontSize: 30.0),)) : new Text("Carregando");

                  } ),

              new Padding(
                padding: EdgeInsets.all(5.0),
                child: new Card(
                  child: new ListTile(
                    title: new Center(child: Text("Ingredientes")),
                    subtitle: new StreamBuilder(

                        stream: produtoselecionado.stream,
                        builder: (context,snapshot){

                      return snapshot.hasData ? new Text(_createIngredientes()) : new Text("Carregando");

                    }),
                  ),
                ),
              ),




              new Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  child: new SizedBox(
                      width: MediaQuery.of(context).size.width,

                      child: new TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            labelText: "Sua observação",
                            hintText: "Seja breve e intuitivo",
                            border: OutlineInputBorder()
                        ),
                        maxLines: 5,
                      )
                  ),
                ),
              ),
            ],
          ),*/
        ),
      ),
      bottomNavigationBar: new Container(
        height: 100.0,
        child: Column(
          children: <Widget>[
            new Center(
              child: new FlatButton(
                  onPressed: () {},
                  child: new Text(
                    "Alguma observação?Clique aqui",
                    style: TextStyle(fontSize: 18.0),
                  )),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: new Stack(
                      children: <Widget>[
                        new Positioned(
                          right: 0.0,
                          bottom: 2.0,
                          child: new SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: new DecoratedBox(
                              decoration: new BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0))),
                              child: new FlatButton(
                                onPressed: () {
                                  if (quantidade.value < 99)
                                    quantidade.sink.add(quantidade.value + 1);
                                },
                                child: new Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        new Positioned(
                            left: 0.0,
                            bottom: 2.0,
                            child: new SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: new DecoratedBox(
                                decoration: new BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(20.0))),
                                child: new FlatButton(
                                  onPressed: () {
                                    if (quantidade.value > 1)
                                      quantidade.sink.add(quantidade.value - 1);
                                  },
                                  child: new Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                        new Positioned(
                          left: 50.0,
                          right: 50.0,
                          bottom: 2.0,
                          child: new SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: new DecoratedBox(
                                  decoration:
                                      new BoxDecoration(color: Colors.white),
                                  child: new StreamBuilder(
                                      stream: quantidade.stream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        return new Center(
                                          child: new Text(
                                            '${snapshot.data}',
                                            style: TextStyle(fontSize: 25.0),
                                          ),
                                        );
                                      }))),
                        ),

                        /*   new Positioned(
                                  top: 0.0,
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: new Container(child: new Text("2"),width: 10.0,height: 10.0,color: Colors.white,),
                                )*/
                      ],
                    ),
                  ),
                  new SizedBox(
                    width: 150.0,
                    height: 50.0,
                    child: new DecoratedBox(
                        decoration: new BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: new FlatButton.icon(
                            onPressed: () {
                              var produto = produtoselecionado.value;
                              produto.qtd = quantidade.value;

                              produto.obs = controller.text;

                              List pedidos = meupedido.value.listprodutos;
                              pedidos.add(produto);

                              meupedido.sink.add(Pedido(listprodutos: pedidos));

                              Fluttertoast.showToast(
                                  msg: "Adicionado com sucesso ao seu carrinho",
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIos: 1);
                            },
                            icon: new Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: new Text(
                              "Adicionar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ))),
                  ),
                ]),
          ],
        ),
      ),
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
