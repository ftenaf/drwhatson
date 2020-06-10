import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key key}) : super(key: key);

  final String title = 'Diario';
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  final List<String> _list = [
    'Fatiga',
    'Estornudos',
    'Perdida de olfato',
    'Perdida de gusto',
    'Congestion Nasal Intensa',
    'Mucosidad',
    'Mucosidad transparente',
    'Mucosidad amarilla o verde',
    'Picor de nariz intenso',
    'Picor de nariz leve',
    'Taponamiento nasal',
    'Decimas de fiebre',
    'Fiebre Alta',
    'Fiebre',
    'Tos Productiva',
    'Tos Seca',
    'Dolor de garganta',
    'Dolor de pecho',
    'Dolor de garganta',
    'Dolor muscular',
    'Dolor abdominal',
    'Dolor de cabeza',
    'Diarrea',
    'Dificultad para respirar',
    'Picor de ojos (conjuntivitis)',
    'Asma'
  ];

  List _items;
  DateTime _selectedDay;
  @override
  void initState() {
    super.initState();
    _items = _list.toList();
    _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          //_buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          /*_buildButtons(),
          const SizedBox(height: 8.0),*/
          Expanded(child: _buildEventList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _bottomSheet(context);
          //await Navigator.push(context, MaterialPageRoute(builder: (context) => AddCalendarData()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: EasyLocalization.of(context).locale.toString(),
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialSelectedDay: DateTime.now(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      initialCalendarFormat: CalendarFormat.twoWeeks,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mes',
        CalendarFormat.twoWeeks: '2 Semanas',
        CalendarFormat.week: 'Semanal',
      },
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }

  _bottomSheet(BuildContext context) {
    double _fontSize = 25;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.blue[400],
        builder: (BuildContext context) {
          return ListView(shrinkWrap: true, padding: const EdgeInsets.all(4.0), children: <Widget>[
            RaisedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Tags(
                symmetry: true,
                columns: 1,
                horizontalScroll: false,
                heightHorizontalScroll: 60 * (_fontSize / 14),
                textField: TagsTextField(
                  autofocus: false,
                  hintText: 'Etiqueta',
                  duplicates: false,
                  textStyle: TextStyle(
                    fontSize: _fontSize,
                    //height: 1
                  ),
                  enabled: true,
                  constraintSuggestion: true,
                  suggestions: [
                    "One",
                    "two",
                    "android",
                  ],
                  onSubmitted: (String str) {
                    setState(() {
                      _items.add(str);
                    });
                  },
                ),
                itemCount: _items.length,
                itemBuilder: (index) {
                  final item = _items[index];

                  return ItemTags(
                    key: Key(index.toString()),
                    index: index,
                    title: item,
                    pressEnabled: true,
                    activeColor: Colors.blue[800],
                    singleItem: false,
                    color: Colors.blue[100],
                    splashColor: Colors.blue,
                    combine: ItemTagsCombine.withTextBefore,
                    textScaleFactor: utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
                    textStyle: TextStyle(
                      fontSize: _fontSize,
                    ),
                  );
                })
          ]);
        });
  }
}
