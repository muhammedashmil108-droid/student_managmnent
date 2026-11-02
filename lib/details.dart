import 'package:flutter/material.dart';
import 'package:student_management/addpage.dart';
import 'package:student_management/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Details extends StatefulWidget {
  final dynamic student;
  final dynamic studentKey;
  Details({super.key, required this.student, required this.studentKey});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Map<String, dynamic> student;

  @override
  void initState() {
    super.initState();
    student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
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
                    CircleAvatar(
                      radius: 60,
                      child: Icon(Icons.person, size: 50),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.student['name']}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(Icons.cake_outlined),
                  title: Text('Age'),
                  subtitle: Text("${widget.student['age']}"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.school),
                  title: Text('Class'),
                  subtitle: Text("${widget.student['class']}"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Address'),
                  subtitle: Text("${widget.student['address']}"),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPage(
                        student: widget.student,
                        studentKey: widget.studentKey,
                      ),
                    ),
                  );

                  final box = Hive.box('students');
                  final updatedStudent = box.get(widget.studentKey);
                  if (updatedStudent != null) {
                    setState(() {
                      student = updatedStudent;
                    });
                  }
                },
                child: Text('Edit'),
              ),

              SizedBox(height: 10),

              // delete button
              ElevatedButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Confirm Delete'),
                        content: Text(
                          'Are you sure you want to delete this student?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirm == true) {
                    final box = Hive.box('students');

                    await box.delete(widget.studentKey);

                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
