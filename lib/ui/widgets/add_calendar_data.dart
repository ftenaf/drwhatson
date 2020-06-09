import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCalendarData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AddCalendarDataState();
}

class _AddCalendarDataState extends State<AddCalendarData> {
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _dateController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  DateTime _dateTime = DateTime.now();

  _selectedDate(BuildContext context) async {
    var _pickDate = await showDatePicker(
        context: context, initialDate: _dateTime, firstDate: DateTime(2000), lastDate: DateTime(2050));
    if (_pickDate != null) {
      setState(() {
        _dateTime = _pickDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_pickDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Add to calendar'))),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Theme(
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: 'Pick a date',
                  labelText: 'Date  ',
                  labelStyle: TextStyle(color: myFocusNode.hasFocus ? Colors.blue : Colors.black),
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedDate(context);
                    },
                    child: Icon(Icons.date_range),
                  ),
                ),
              ),
              data: Theme.of(context).copyWith(
                primaryColor: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Colors.blueGrey,
              ),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'title'),
              ),
            ),
            SizedBox(height: 10),
            Theme(
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              data: Theme.of(context).copyWith(primaryColor: Colors.blueGrey),
            ),
            SizedBox(height: 20),
            RaisedButton(
                child: Text('Add'),
                onPressed: () {
                  _addPlant();
                }),
          ],
        ),
      ),
    );
  }

  void _addPlant() {
    Navigator.pop(context);
  }
}
