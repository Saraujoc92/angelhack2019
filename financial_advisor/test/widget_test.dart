// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:financial_advisor/services/cuotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:financial_advisor/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    
    CuotationProvider provider = MockCuotationProvider();
    var expense = await provider.getNewExpense(3500000, 24);
    print('$expense');
    List<double> expense2 = await provider.getPaymentCalendar();
    print('${expense2.reduce((a, b) => a + b)}');
  });
}
