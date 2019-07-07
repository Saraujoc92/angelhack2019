import 'dart:math';

abstract class CuotationProvider {
  getCardInfo(userId);
  getNewExpense(cost, split);
  getPaymentCalendar();
  getSimulation(cost, split);
}

class MockCuotationProvider extends CuotationProvider {
  @override
  Future getCardInfo(userId) async {
    var cardInfo = {
      'paymentDate': null,
      'currentCuotation': 281500.0,
      'currentDebt': 3500000.0,
      'interestType': null,
      'interestPayment': null,
      'interestRate': .22 / 12, // anual
    };
    return cardInfo;
  }

  @override
  getNewExpense(cost, split) async {
    // var Interes= 22;//tasa interés
    // var Capital=3500000;//Prestamo
    // var Meses=24;//Numero de cuotas
    var cardInfo = await getCardInfo(null);
    var interest = cardInfo['interestRate'];

    var cuotation = cost /
        ((1 - pow(interest + 1, -split)) / interest); //Cuota fija mensual
    var extraCost = (split * cuotation) - cost; //Interés (final)

    return {
      'cuotation': cuotation,
      'extraCost': extraCost,
    };
  }

  getPaymentCalendar() async {
    var cardInfo = await getCardInfo(null);

    double currentCuotation = cardInfo['currentCuotation'];
    double currentDebt = cardInfo['currentDebt'];

    var paymentCount = (currentDebt / currentCuotation).ceil();
    var lastPayment = (currentDebt % currentCuotation);

    List<double> payments = [];
    for (var i = 0; i < paymentCount - 1; i++) {
      payments.add(currentCuotation);
    }
    payments.add(lastPayment);
    return payments;
  }

  getSimulation(cost, split) async {
    var paymentCalendar = await getPaymentCalendar();
    var newExpense = await getNewExpense(cost, split);

    var newCuotationCount =
        paymentCalendar.length > split ? paymentCalendar.length : split;
    List<double> newPaymentCalendar = [];
    for (var i = 0; i < newCuotationCount; i++) {
      var value = 0.0;
      if (i < paymentCalendar.length) value += paymentCalendar[i];
      if (i < split) value += newExpense['cuotation'];
      newPaymentCalendar.add(value);
    }
    return newPaymentCalendar;
  }
}
