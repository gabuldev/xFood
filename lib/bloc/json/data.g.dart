/*
* RESPONSAVEL POR FAZER O PARSE DO JSON E A TRANSFORMACAO EM JSON
* */

part of 'data.dart';

Produto _$ProdutoFromJson(Map<String,dynamic> json){

  return Produto(
    nome: json['nomeProduto'] as String,
    categoria: json['idCategoria'] as int,
    descricao: json['descricaoProduto'].split(",") as List<String>,
    foto: json['urlProduto'] as String,
    preco: json['precoProduto'] as double
  );

}

Empresa _$EmpresaFromJson(Map<String,dynamic> json){

  return Empresa(
      nome: json['nomeEmpresa'] as String,
      categoria: Categoria.fromJson(json['categoria']) ,
      cardapio: Cardapio.fromJson(json['cardapio']) ,
      endereco: json['enderecoEmpresa'] as String,
      horaAberto: json['horaAberto'] as String,
      horaFechado: json['horaFechado'] as String,
      idEmpresa: json['codigoEmpresa'] as int,
      logo: json['logoEmpresa'] as String
  );

}

Cardapio _$CardapioFromJson(Map<String,dynamic> json){

  List<Categoria> categorias = [];
  List<Produto> produtos = [];
   
  for(var item in json['categorias'])
    categorias.add(Categoria.fromJson(item));
  
  for(var item in json['produtos'])
      produtos.add(Produto.fromJson(item));

  return Cardapio(
      categorias: categorias,
      produtos: produtos
  );

}


Categoria _$CategoriaFromJson(Map<String,dynamic> json){

  //PENSAR MELHOR NISSO AQUI

  return Categoria(
      idCategoria: json['idCategoria']as int,
      nomeCategoria: json['nomeCategoria'] as String
  );

}

Carrinho _$CarrinhoFromJson(Map<String,dynamic> json){

  //PENSAR MELHOR NISSO AQUI

  return Carrinho(
     produtos: List<Produto>(),
     endereco: json['endereco'],
     empresa: Empresa.fromJson(json),
     entrega: json['entrega'],
     infoPagamento: json['infoPagamento'],
     pagamento: json['tipoPagamento']
  );

}


