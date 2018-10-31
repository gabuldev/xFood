/*
* AQUI TEMOS TODAS AS CLASSES DO PROJETO
* TODAS AS ENTIDADES ESTARÃO AQUI
* */
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable(nullable: true)
class Produto{

  final String nome;
  final int categoria;
  List<String> descricao;//TRABALHAR OU NÃO COM QUEBRA DE LINHA
  final double preco;
  String obs;
  int qtd;
  final String foto;//URL



  //CONSTRUTOR DA CLASS
  Produto({this.nome,this.descricao,this.preco,this.foto,this.categoria,this.obs,this.qtd});
  factory Produto.fromJson(Map<String,dynamic> json) => _$ProdutoFromJson(json);

}

@JsonSerializable()
class Empresa{

    final String nome;
    final int idEmpresa;
    final String logo;
    final String horaAberto;
    final String horaFechado;
    final String endereco;
    final Categoria categoria;
    final Cardapio cardapio;

    //CONSTRUTOR DA CLASS
    Empresa({this.nome,this.logo,this.horaAberto,this.horaFechado,this.endereco,this.categoria,this.cardapio,this.idEmpresa});
    factory Empresa.fromJson(Map<String,dynamic> json) => _$EmpresaFromJson(json);
}

@JsonSerializable()
class Cardapio{

    final List<Categoria> categorias;
    final List<Produto> produtos;

    //CONSTRUTOR DA CLASS
    Cardapio({this.produtos,this.categorias});
    factory Cardapio.fromJson(Map<String,dynamic> json) => _$CardapioFromJson(json);


}

@JsonSerializable()
class Categoria{

  final int idCategoria;
  final String nomeCategoria;

  //CONSTRUTOR DA CLASS
  Categoria({this.idCategoria,this.nomeCategoria});
  factory Categoria.fromJson(Map<String,dynamic> json) => _$CategoriaFromJson(json);

}

@JsonSerializable()
class Carrinho{

  final Empresa empresa;
  final List<Produto> produtos;
  final String pagamento;
  final String infoPagamento;//AQUI SE FOR CARTAO VAI A BANDEIRA, SE FOR DINHEIRO VAI O TROCO
  final bool entrega;//BOOLEAN PARA VERIFICAR SE EH OU NAO ENTREGA
  final String endereco;

  //CONSTRUTOR DA CLASS
  Carrinho({this.empresa,this.produtos,this.endereco,this.entrega,this.infoPagamento,this.pagamento});
  factory Carrinho.fromJson(Map<String,dynamic> json) => _$CarrinhoFromJson(json);

}

