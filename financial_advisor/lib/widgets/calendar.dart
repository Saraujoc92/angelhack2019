import 'package:financial_advisor/utils/date.dart';
import 'package:financial_advisor/widgets/expense_graph.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final List<double> payments;

  Calendar({this.payments});

  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime currentDate = DateTime.now();

  _prevMonth() {
    var month;
    var year;
    if (currentDate.month - 1 < 0) {
      month = 12;
      year = currentDate.year - 1;
    } else {
      month = currentDate.month - 1;
      year = currentDate.year;
    }
    setState(() {
      currentDate = DateTime(year, month);
    });
  }

  _nextMonth() {
    var month;
    var year;
    debugPrint('currentDate.month ${currentDate.month}');
    if (currentDate.month + 1 > 12) {
      month = 1;
      year = currentDate.year + 1;
    } else {
      month = currentDate.month + 1;
      year = currentDate.year;
    }
    debugPrint('new month $month');
    debugPrint('new year $year');
    setState(() {
      currentDate = DateTime(year, month);
    });
  }

  get _monthIndex {
    var index;
    var now = DateTime.now();
    if (currentDate.year == now.year) index = currentDate.month - now.month;
    index = (currentDate.year - now.year) * 12 + currentDate.month - now.month;
    debugPrint('index: $index');
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(Icons.calendar_today),
        Row(
          children: <Widget>[
            Spacer(),
            IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: _monthIndex > 0 ? _prevMonth : null,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(month(currentDate)),
            SizedBox(
              width: 5.0,
            ),
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: _monthIndex < (widget.payments.length - 1)
                  ? _nextMonth
                  : null,
            ),
            Spacer()
          ],
        ),
        Text('\$ ${widget.payments[_monthIndex].toStringAsFixed(2)}'),
      ],
    );
  }
}
