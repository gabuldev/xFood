import 'package:flutter/material.dart';
import 'package:xfood/pages/restaurante_page.dart';
import 'package:xfood/bloc/bloc.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:xfood/pages/notifications_page.dart';
import 'package:xfood/pages/menu_page.dart';
import 'package:xfood/pages/search_page.dart';

class HomePage extends StatefulWidget {
  Bloc bloc = Bloc();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    widget.bloc.loadingAllEmpresas();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: new Scaffold(
            backgroundColor: Colors.yellow,
            floatingActionButton: new FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()));},
              child: new Icon(Icons.search),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            appBar: new PreferredSize(
                child: SizedBox(
                  height: 300.0,
                  child: new Column(children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(top:30.0,left: 10.0,right: 10.0),
                      child: new SizedBox(
                          height: 200.00,
                          child: new DecoratedBox(decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                            child: new Carousel(
                              backgroundColor: Colors.yellow,
                              borderRadius: true,
                              noRadiusForIndicator: false,
                              autoplayDuration: Duration(seconds: 5),
                              boxFit: BoxFit.fill,
                              dotIncreaseSize: 1.5,
                              showIndicator: false,
                              radius: Radius.circular(20.0),

                              images: [
                                new NetworkImage('http://www.gullasfastfood.com.br/wp-content/uploads/2017/05/promocao-sexta-e-terca-1.jpg'),
                                new NetworkImage('https://blogdoarmindo.com.br/wp-content/uploads/2018/02/diasdepromo%C3%A7%C3%A3oRagazzo.jpg'),
                              ],
                            ),
                          )),
                    ),

                    new Padding(padding: EdgeInsets.all(5.0),child:
                    new DecoratedBox(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: new TabBar(
                            indicator: ShapeDecoration.fromBoxDecoration(
                                BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50.0))),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              new Tab(
                                child: new Text(
                                  "Restaurantes",
                                ),
                              ),
                              new Tab(
                                child: new Text(
                                  "Favoritos",
                                ),
                              )
                            ])),),
                  ],)
                ),
                preferredSize: Size.fromHeight(264.0)),
            body: new TabBarView(children: <Widget>[
               new StreamBuilder(

                   stream: empresas.stream.distinct(),
                   builder: (context,snapshot){

                     return snapshot.hasData ?new ListView.builder(
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
                         }) : new Center(child: new CircularProgressIndicator(),);


                   }),

               new Text("Favoritos")

             ],
            ),
          bottomNavigationBar: new BottomAppBar(
            shape: CircularNotchedRectangle(),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new IconButton(icon: new Icon(Icons.menu), onPressed: (){

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>MenuPage()));

                }),
                new IconButton(icon: new Stack(children: <Widget>[

                  new Icon(Icons.notifications,size: 30.0,),
                  new Positioned(child: new CircleAvatar(child: new Text("1"),maxRadius: 10.0,backgroundColor: Colors.green,),left: 0.0,)

                ],), onPressed: (){ Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationsPage()));}),
              ],
            ) ,
          )
        ),
      ),
    );
  }
}

class _DemoDrawer extends StatelessWidget {
  const _DemoDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
          ),
          ListTile(
            leading: Icon(Icons.threed_rotation),
            title: Text('3D'),
          ),
        ],
      ),
    );
  }
}