import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PagamentoPage extends StatefulWidget {
  @override
  _PagamentoPageState createState() => _PagamentoPageState();
}

class _PagamentoPageState extends State<PagamentoPage> {
  var controler = MoneyMaskedTextController(
      thousandSeparator: ".", decimalSeparator: ",", leftSymbol: "R\$: ");
  bool selecionadodinheiro = false;
  bool selecionadocartao = false;

  void selected() {
    if (selecionadodinheiro == false) {
      setState(() {
        selecionadodinheiro = true;
        selecionadocartao = false;
      });
    } else {
      setState(() {
        selecionadocartao = true;
        selecionadodinheiro = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text("Pagamento em dinheiro"),
          leading: new IconButton(
              icon: new Icon(selecionadodinheiro == true
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
              onPressed: () {
                selected();
              }),
        ),

        new Padding(
            padding: new EdgeInsets.only(top: 5.0, right: 120.0, left: 120.0),
            child: new TextFormField(
              controller: controler,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Valor do troco",
                  labelStyle: TextStyle(fontSize: 22.0)),
            )),

        new ListTile(
          title: new Text("Pagamento em cartão"),
          leading: new IconButton(
              icon: new Icon(selecionadocartao == true
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
              onPressed: () {
                selected();
              }),
        ),

        new Center(child: new Text("Selecione sua bandeira"),),

        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(5.0),child:
            new SizedBox(width: 50.0,height: 40.0,child: new Image.network("https://0800telefone.com/wp-content/uploads/2016/06/0800-visa.png",color: Colors.grey,),)
            ),

            new Padding(padding: EdgeInsets.all(5.0),child:
            new SizedBox(width: 50.0,height: 40.0,child: new Image.network("https://www.cashpassport.com.br/media/7234912/mastercard-features.png",color: Colors.grey,),)
            ),

            new Padding(padding: EdgeInsets.all(5.0),child:
            new SizedBox(width: 50.0,height: 40.0,child: new Image.network("https://logodownload.org/wp-content/uploads/2017/04/elo-logo-1-1.png",color: Colors.grey,),)
            ),

            new Padding(padding: EdgeInsets.all(5.0),child:
            new SizedBox(width: 50.0,height: 40.0,child: new Image.network("https://logodownload.org/wp-content/uploads/2016/03/ticket-logo-5.png",color: Colors.grey,),)
            ),


          ],
        ),


        new ListTile(
          title: new Text("Entregar"),
          leading: new IconButton(
              icon: new Icon(selecionadocartao == true
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
              onPressed: () {
                selected();
              }),
        ),
        new ListTile(
          title: new Text("Retirar local"),
          leading: new IconButton(
              icon: new Icon(selecionadocartao == true
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
              onPressed: () {
                selected();
              }),
        )

      ],
    );
  }
}
