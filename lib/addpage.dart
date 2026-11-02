import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddPage extends StatefulWidget {
  final dynamic student;
  final dynamic studentKey;

  const AddPage({super.key, this.student, this.studentKey});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      namecontroller.text = widget.student!['name'];
      agecontroller.text = widget.student!['age'].toString();
      classcontroller.text = widget.student!['class'].toString();
      addresscontroller.text = widget.student!['address']?.toString() ?? '';
    }
  }

  final namecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final classcontroller = TextEditingController();
  final addresscontroller = TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    agecontroller.dispose();
    classcontroller.dispose();
    addresscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 60, backgroundColor: Colors.blue),
                  SizedBox(height: 10),
                  Text(
                    "Add image",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Age",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: agecontroller,
                          decoration: InputDecoration(
                            hintText: "Enter your age",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Class",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: classcontroller,
                          decoration: InputDecoration(
                            hintText: "Enter your class",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Class",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 10),
                        Text(
                          "Address",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          maxLines: 3,
                          controller: addresscontroller,
                          decoration: InputDecoration(
                            hintText: "Enter your address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                Map<String, dynamic> student = {
                                  "name": namecontroller.text.trim(),
                                  "age":
                                      int.tryParse(agecontroller.text.trim()) ??
                                      0,
                                  "class":
                                      int.tryParse(
                                        classcontroller.text.trim(),
                                      ) ??
                                      0,
                                  "address": addresscontroller.text.trim(),
                                };
                                //  get hive box
                                final box = Hive.box('students');

                                // update operation
                                if (widget.studentKey != null) {
                                  // update operation
                                  await box.put(widget.studentKey, student);
                                } else {
                                  //add operation
                                  await box.add(student);
                                }
                                // // save student in hive
                                // await box.add(student);
                                //  close add page
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              },

                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                widget.student == null
                                    ? "Add Student"
                                    : "Update Student",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
