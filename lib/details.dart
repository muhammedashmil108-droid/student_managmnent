import 'package:flutter/material.dart';
import 'package:student_management/home.dart';

class Details extends StatefulWidget {
  dynamic student;
  new({super.key, required this.student});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Details",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    CircleAvatar(maxRadius: 40, child: Icon(Icons.person)),
                    SizedBox(height: 10),
                    Text(
                      "${widget.student["name"]}",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.cake),
                  title: Text("Age"),
                  subtitle: Text("${widget.student["age"]}"),
                ),
              ),
              SizedBox(height: 20),

              Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.school),
                  title: Text("Class"),
                  subtitle: Text("${widget.student["class"]}"),
                ),
              ),
              SizedBox(height: 20),

              Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text("Address"),
                  subtitle: Text("${widget.student["address"]}"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
