import 'package:flutter/material.dart';

class eventdetails extends StatefulWidget {
  String festival;
  String date;
  String description;
  eventdetails(this.festival, this.date, this.description);
  // const eventdetails({super.key});

  @override
  State<eventdetails> createState() => _eventdetailsState();
}

class _eventdetailsState extends State<eventdetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/festival.png",
              width: 180,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Upcoming festival or event",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    blurRadius: 5.0,
                    offset: Offset(0, 3.0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    widget.festival,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.date),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
