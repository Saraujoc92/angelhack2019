import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            promoCard(
              'assets/images/promos/promo1.png',
              '18 CUOTAS SIN INTERÉS',
              'En TV y celulares por este mes con el código KTRONTUQR',
              'https://www.ktronix.com/ofertas',
            ),
            promoCard(
              'assets/images/promos/promo2.png',
              'El TV que soñaste',
              'AHORA EN PROMOCIÓN con el código JUMBOTUKYT',
              'https://www.tiendasjumbo.co/ofertas',
            ),
            promoCard(
              'assets/images/promos/promo3.png',
              'DESCUENTOS',
              'Aprovecha para comprar frutas y verduras. Descuento adicional con el código EXITOTU2019',
              'https://www.exito.com/browse?Ntt=Desc_304080ny0ur7&No=0&Nrpp=80',
            ),
          ],
        ),
      ),
    );
  }

  Widget promoCard(asset, title, text, url) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: GestureDetector(
        onTap: () => _launchURL(url),
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
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
