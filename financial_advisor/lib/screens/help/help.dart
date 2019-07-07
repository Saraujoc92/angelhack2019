
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  Help({ Key key }) : super(key: key);

  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda')
      ),
      body: SingleChildScrollView(child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.all(20), child: Image.network('https://www.panorama.com.ve/__export/1474558616109/sites/panorama/img/politicayeconomia/2016/09/22/tarjetasdecredito.jpg_1669210832.jpg')),
          Text('¿Qué tipos de crédito hay?', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.red)),
          Divider(color: Colors.red, height: 10.0),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text('Créditos gota a gota: No necesitas ningún papeleo para pedirlo y el dinero lo obtienes inmediatamente, pero sus intereses pueden ser tan altos como peligrosos, además porque no tienen alguna regulación.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text('Créditos formales: Los prestamos pueden ser a largo plazo, respaldados por las regulaciones del gobierno. Creas una vida crediticia, y si es buena, obtienes beneficios a largo plazo con diferentes entidades financieras como te enseñará crediTÚ. Todo para asegurar tus sueños sin preocuparte por deudas letales.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
          child: Text('¿Interés?', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.red))),
          Divider(color: Colors.red, height: 10.0),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text(' Un porcentaje del monto pedido, que pagas adicionalmente en retribución por el préstamo. Pero las entidades bancarias pueden utilizar los siguientes:', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text('Interés nominal: un porcentaje del monto total del préstamo que se paga en periodos mensuales, trimestrales, anuales o según como defina el prestamista, sin que varíe periodo a periodo.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text('Interés efectivo: un porcentaje que se acumula. Por ejemplo, en tu primer periodo de pago de intereses, el porcentaje se calcula al monto total que pediste, pero en tu segundo pago el porcentaje se calcula con lo que te queda por pagar más el interés calculado en el primer periodo. El valor del interés que pagas mes a mes varía según tu avance.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Divider(),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0), child: RichText(text: TextSpan(
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0),
            children: [
              TextSpan(text: 'Pero si quieres financiarte tu mismo: ', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
              TextSpan(text: '¡Ahorra! ', style: TextStyle(fontWeight: FontWeight.w800)),
              TextSpan(text: 'Puede ser el 10% de tus ingresos, para cualquier imprevisto. Uno nunca sabe que pueda pasar.', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400))
            ]
          ))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text('¡Controla tus deudas!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.red))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
          child: Text('- Ten en cuenta tu deuda exacta.', textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Text('- Ahorra y ten por lo menos un fondo de emergencia.', textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Text('- Invierte el 100% del préstamo únicamente para lo que lo solicitaste. Recuerda tu planificación.', textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Text('- Vive tranquilo sin sentir que le debes a todo el mundo.', textAlign: TextAlign.left, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400))),
          Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Text('Pero también puedes Invertir para hacer crecer tus ahorros, claro, en función del riesgo que esto implica.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.red))),
          Padding(padding: EdgeInsets.all(20), child: Image.network('https://images.news18.com/ibnlive/uploads/2018/01/money.jpg'))
        ])
    )));
  }
}