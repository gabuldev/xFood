import 'package:rxdart/rxdart.dart';
import 'package:xfood/bloc/function/functions.dart';
import 'package:xfood/bloc/json/data.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


class Bloc{

  Database database = DatabaseImplements();
  var listProdutos = List<List<Produto>>();



  //FUNÇÕES

  loadingEmpresa(int codigoEmpresa) async{
    empresaselecionada.sink.add(await database.getEmpresa(codigoEmpresa));
  }

  loadingAllEmpresas() async{
   empresas.sink.add(await database.getAllEmpresas());
  }

 String verificaAberto({String horaAberto, String horaFechado}){
    String abertoH = horaAberto.substring(0,2);
    String abertoM = horaAberto.substring(3,5);
    String fechadoH = horaFechado.substring(0,2);
    String fechadoM = horaFechado.substring(3,5);

    DateTime now = DateTime.now();
    DateTime open = DateTime(now.year,now.month,now.day,int.parse(abertoH),int.parse(abertoM));
    DateTime close = DateTime(now.year,now.month,now.day,int.parse(fechadoH),int.parse(fechadoM));

    if(now.difference(open).isNegative== false && now.difference(close).isNegative == true)
      return "Aberto";
    else
      return "Fechado";

  }

  bool verificaAbertoBool({String horaAberto, String horaFechado}){
    String abertoH = horaAberto.substring(0,2);
    String abertoM = horaAberto.substring(3,5);
    String fechadoH = horaFechado.substring(0,2);
    String fechadoM = horaFechado.substring(3,5);

    DateTime now = DateTime.now();
    DateTime open = DateTime(now.year,now.month,now.day,int.parse(abertoH),int.parse(abertoM));
    DateTime close = DateTime(now.year,now.month,now.day,int.parse(fechadoH),int.parse(fechadoM));

    if(now.difference(open).isNegative== false && now.difference(close).isNegative == true)
      return true;
    else
      return false;

  }

 List<Tab> criartabs(){

    List<Tab> lista = [];

   for(var item in empresaselecionada.value.cardapio.categorias){

        lista.add(Tab(
            child: new Text(item.nomeCategoria),
        ));
   }

   return lista;

 }


 List<dynamic> criarProdutos(){

    List<Produto> produtos = [];
    List<dynamic> categoriaproduto = [];

    for(var i = 0 ; i<empresaselecionada.value.cardapio.categorias.length;i++) {
            produtos = [];
      for (var item in empresaselecionada.value.cardapio.produtos){

            if(i == item.categoria){
              produtos.add(item);
            }

      }
      categoriaproduto.add(produtos);
    }

    print(categoriaproduto);
    return categoriaproduto;

 }


}


class Pedido{

  List<Produto> listprodutos;

  Pedido({this.listprodutos});
  double valorTotal(){

    double total = 0.0;

    for(var item in listprodutos){
      total+=item.preco;
    }

    return total;

  }

}



//MINHAS STREAMS
var empresaselecionada = BehaviorSubject<Empresa>();
var empresas = BehaviorSubject<List<Empresa>>();
var meupedido = BehaviorSubject<Pedido>(seedValue: Pedido(listprodutos:List<Produto>()));
var produtoselecionado = BehaviorSubject<Produto>();