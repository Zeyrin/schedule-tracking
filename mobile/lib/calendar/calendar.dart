import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:schedule_tracking/calendar/event.dart';
import 'package:schedule_tracking/calendar/event_provider.dart';
import 'package:schedule_tracking/calendar/event_data_source.dart';
import 'package:schedule_tracking/calendar/taskswidget.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => EventProvider(),
    child: MaterialApp(debugShowCheckedModeBanner: false,home: CalendarPagetwo()),
  );
}

class CalendarPagetwo extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    body: CalendarWidget(),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventEditingPage()),
      ),
    ),
  );
}

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return SfCalendar(
      dataSource: EventDataSource(events),
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details) {
        final provider = Provider.of<EventProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}