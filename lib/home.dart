import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management/addpage.dart';

import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  late Box studentsBox;

  @override
  void initState() {
    super.initState();
    studentsBox = Hive.box('students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                  ),
                ],
              ),

              Text(
                "Student management",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: studentsBox.listenable(),
                  builder: (context, box, child) {
                    final students = box.values.toList();
                    final studentkeys = box.keys.toList();

                    if (students.isEmpty) {
                      return Center(child: Text("No students added yet"));
                    }

                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        final studentKey = studentkeys[index];

                        return Card(
                          margin: EdgeInsets.all(10),
                          elevation: 4,

                          child: ListTile(
                            leading: CircleAvatar(child: Icon(Icons.person)),
                            title: Text(student["name"].toString()),
                            // subtitle: Text(
                            //   "age: ${student["age"]} | class: ${student["class"]} ",
                            // ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    student: student,
                                    studentKey: studentKey,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPage()),
                  );
                },
                child: Icon(Icons.add),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
