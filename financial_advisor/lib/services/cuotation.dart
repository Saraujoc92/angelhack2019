import 'dart:math';

abstract class CuotationProvider {
  getCardInfo(userId);
  getNewExpense(double cost, int split);
  getNewExpenseCuotation(cost, cuotation);
  getPaymentCalendar();
  getSimulationWithCuotationCount(cost, split);
  getSimulationWithCuotation(cost, cuotation);
}

class MockCuotationProvider extends CuotationProvider {
  @override
  Future getCardInfo(userId) async {
    var cardInfo = {
      'paymentDate': null,
      'currentCuotation': 0.0,
      'currentDebt': 0.0,
      'interestType': null,
      'interestPayment': null,
      'interestRate': .22 / 12, // anual
    };
    return cardInfo;
  }

  @override
  getNewExpense(double cost, int split) async {
    var cardInfo = await getCardInfo(null);
    var interest = cardInfo['interestRate'];

    var ki = ((1 - pow(interest + 1, -split)) / interest);
    var cuotation = cost / ki; //Cuota fija mensual
    var extraCost = (split * cuotation) - cost; //Interés (final)

    return {
      'cuotation': cuotation,
      'extraCost': extraCost,
    };
  }

  @override
  getNewExpenseCuotation(cost, cuotation) async {
    var cardInfo = await getCardInfo(null);
    var interest = cardInfo['interestRate'];

    // var cuotation = cost /
    //     ((1 - pow(interest + 1, -split)) / interest); //Cuota fija mensual
    // var extraCost = (split * cuotation) - cost; //Interés (final)

    // return {
    //   'cuotation': cuotation,
    //   'extraCost': extraCost,
    // };    return null;
  }

  getPaymentCalendar() async {
    var cardInfo = await getCardInfo(null);

    double currentCuotation = cardInfo['currentCuotation'] ;
    double currentDebt = cardInfo['currentDebt'];

    var paymentCount =
        currentCuotation > 0 ? (currentDebt / currentCuotation).ceil() : 0;
    var lastPayment = currentDebt > 0 ? (currentDebt % currentCuotation) : 0.0;

    List<double> payments = [];
    for (var i = 0; i < paymentCount - 1; i++) {
      payments.add(currentCuotation);
    }
    payments.add(lastPayment);
    print('payments $payments');
    return payments;
  }

  getSimulationWithCuotationCount(cost, split) async {
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
    print('newPaymentCalendar $newPaymentCalendar');
    return newPaymentCalendar;
  }

  @override
  getSimulationWithCuotation(cost, cuotation) async {
    return null;
  }
}
