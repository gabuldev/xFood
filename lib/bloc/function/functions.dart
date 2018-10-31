import 'package:xfood/bloc/json/data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

abstract class Database{
  
  Future<dynamic> getEmpresa(int codigoEmpresa);
  Future<dynamic> getAllEmpresas();
  
}

class DatabaseImplements implements Database{
  @override
  Future<Empresa> getEmpresa(int codigoEmpresa)async {
    http.Response response =
    await http.get("https://kallifa-5ef79.firebaseio.com/empresas/$codigoEmpresa.json");

    if(response.statusCode != 200)
      return null;
    else {
      print(Empresa.fromJson(jsonDecode(response.body)));
      return Empresa.fromJson(jsonDecode(response.body));
    }
  }

  @override
  Future getAllEmpresas() async{
    List<Empresa> lista = [];
    List<dynamic> list = [];
    http.Response response =
        await http.get("https://kallifa-5ef79.firebaseio.com/empresas.json");

    if(response.statusCode != 200)
      return null;
    else {
      list = jsonDecode(response.body);
      for(var item in list)
        lista.add(Empresa.fromJson(item));
      return lista;
    }
  }

  
}