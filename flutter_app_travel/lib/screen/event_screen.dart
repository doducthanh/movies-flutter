import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutterapptravel/consts/model.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sự kiện", style: TextStyle(fontSize: 24), textAlign: TextAlign.center,)),
        leading: IconButton(
          icon: Icon(Icons.filter_list, color: Colors.white,),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: showAlert
          )
        ],
      ),
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) => itemEvent(),
            separatorBuilder: (context, index) => SizedBox(height: 16,),
            itemCount: 10),
      ),
    );
  }

  void showAlert() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: 250, height: 300,
          child: CalendarCarousel<Event>(
            selectedDayButtonColor: Colors.green,
          ),
        ),
      );
    });
  }

  Widget itemEvent() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("28/04/2020: SAPA", style: TextStyle(fontSize: 24),),
          Image.asset(venice.urlImage, height: 250, fit: BoxFit.cover,),
        ],
      ),
    );
  }
}
