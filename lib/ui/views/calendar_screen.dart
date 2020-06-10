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

  final String title = 'calendar.title'.tr();
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  List _items;
  DateTime _selectedDay;

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

  bool isSelected(String item) {
    return _selectedEvents.contains(item);
  }

  @override
  void initState() {
    super.initState();
    _items = _list.toList();
    _selectedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    _events = new Map<DateTime, List>();
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
    setState(() {
      _selectedDay = new DateTime(day.year, day.month, day.day);
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
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _bottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: EasyLocalization.of(context).locale.toString(),
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialSelectedDay: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25), bottom: Radius.zero),
            side: BorderSide(color: Colors.blue[800], width: 1, style: BorderStyle.solid)),
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.5,
              child: ListView(shrinkWrap: true, padding: const EdgeInsets.all(12.0), children: <Widget>[
                Tags(
                    symmetry: true,
                    columns: 1,
                    horizontalScroll: false,
                    heightHorizontalScroll: 60 * (_fontSize / 14),
                    textField: TagsTextField(
                      autofocus: false,
                      hintText: 'calendar.sintoma'.tr(),
                      duplicates: false,
                      textStyle: TextStyle(
                        fontSize: _fontSize,
                        //height: 1
                      ),
                      enabled: true,
                      constraintSuggestion: true,
                      suggestions: [
                        "Dermatitis",
                        "Tension Alta",
                      ],
                      onSubmitted: (String str) {
                        setState(() {});
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
                        active: isSelected(item),
                        activeColor: Colors.blue[800],
                        singleItem: false,
                        color: Colors.blue[100],
                        splashColor: Colors.blue,
                        combine: ItemTagsCombine.withTextBefore,
                        onPressed: (Item x) => onSelectedTag(x),
                        textScaleFactor: utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
                        textStyle: TextStyle(
                          fontSize: _fontSize,
                        ),
                      );
                    })
              ]));
        });
  }

  onSelectedTag(Item x) {
    List events = _events[_selectedDay];
    if (events == null) events = new List<String>();
    if (x.active) {
      if (!events.contains(x.title)) events.add(x.title);
    } else {
      if (events.contains(x.title)) events.remove(x.title);
    }
    setState(() {
      _events[_selectedDay] = events;
      _selectedEvents = _events[_selectedDay];
    });
  }
}
