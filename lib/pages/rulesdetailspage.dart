import 'package:flutter/material.dart';

class rulesdetailspage extends StatefulWidget {
  String title;
  String description;
  rulesdetailspage(this.title, this.description);
  // const rulesdetailspage({super.key});

  @override
  State<rulesdetailspage> createState() => _rulesdetailspageState();
}

class _rulesdetailspageState extends State<rulesdetailspage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
               Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5.0,
                      offset: Offset(0, 3.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: Text(
                  "${widget.title}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5.0,
                      offset: Offset(0, 3.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: Text(
                  "➞ ${widget.description}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
