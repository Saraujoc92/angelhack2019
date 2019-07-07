import 'package:flutter/material.dart';

class PromoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promociones'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            promoCard('assets/images/promos/promo1.png',
                '18 CUOTAS SIN INTERÉS', 'En TV y celulares por este mes'),
            promoCard('assets/images/promos/promo2.png', 'El TV que soñaste',
                'AHORA EN PROMOCIÓN'),
            promoCard('assets/images/promos/promo3.png', 'DESCUENTOS',
                'Aprovecha para comprar frutas y verduras'),
          ],
        ),
      ),
    );
  }

  Widget promoCard(asset, title, text) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: <Widget>[
          Image.asset(asset),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
