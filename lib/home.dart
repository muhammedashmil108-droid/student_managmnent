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
  // List<Map<String, dynamic>> students = [
  //   {"name": "Ashmil", "age": 18, "class": 12},
  //   {"name": "Riswan", "age": 18, "class": 12},
  //   {"name": "Jihan", "age": 19, "class": 12},
  //   {"name": "Shiyas", "age": 19, "class": 12},
  // ];
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

                    if (students.isEmpty) {
                      return Center(child: Text("No students add "));
                    }

                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];

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
                                  builder: (context) =>
                                      Details(student: student),
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
                onPressed: () async {
                  await Navigator.push(
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
