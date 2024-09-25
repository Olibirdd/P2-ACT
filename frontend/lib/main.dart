import 'package:crud_activity/api_service/student_service.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(StudentApp());
}

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    await Future.delayed(Duration(seconds: 0));
    List<Map<String, dynamic>> fetchedStudents = [
    ];

    setState(() {
      students = fetchedStudents;
    });
  }

  void _addStudent(Map<String, dynamic> student) {
    setState(() {
      students.add(student);
    });
  }

  void _updateStudent(int index, Map<String, dynamic> student) {
    setState(() {
      students[index] = student;
    });
  }

  void _deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: students.isEmpty
          ? Center(child: Text('No students available'))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  title: Text('${student['FirstName']} ${student['LastName']}'),
                  subtitle: Text('${student['Course']} - ${student['Year']}'),
                  trailing: Switch(
                    value: student['Enrolled'],
                    onChanged: (value) {
                      setState(() {
                        students[index]['Enrolled'] = value;
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewEditDeleteScreen(
                          student: student,
                          onUpdate: (updatedStudent) {
                            _updateStudent(index, updatedStudent);
                          },
                          onDelete: () {
                            _deleteStudent(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateScreen(
                onCreate: (newStudent) {
                  _addStudent(newStudent);
                },
              ),
            ),
          );
          if(result == true){fetchStudents();}
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onCreate;

  CreateScreen({required this.onCreate});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String course = '';
  String selectedYear = '1st Year'; // Default dropdown value
  bool enrolled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  firstName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  lastName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Course'),
                onSaved: (value) {
                  course = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedYear,
                decoration: InputDecoration(labelText: 'Year'),
                items: <String>['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year']
                    .map((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Enrolled'),
                value: enrolled,
                onChanged: (value) {
                  setState(() {
                    enrolled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ApiService apiService = ApiService();
                    await apiService.createStudentData(
                      firstname: firstName,
                      lastname: lastName,
                      course: course,
                      year: selectedYear ?? '',
                      enrolled: enrolled,
                    );

                    Navigator.pop(context, true);
                  }
                },

                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewEditDeleteScreen extends StatefulWidget {
  final Map<String, dynamic> student;
  final Function(Map<String, dynamic>) onUpdate;
  final Function() onDelete;

  ViewEditDeleteScreen({required this.student, required this.onUpdate, required this.onDelete});

  @override
  _ViewEditDeleteScreenState createState() => _ViewEditDeleteScreenState();
}

class _ViewEditDeleteScreenState extends State<ViewEditDeleteScreen> {
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String course;
  late String selectedYear;
  late bool enrolled;

  @override
  void initState() {
    super.initState();
    firstName = widget.student['FirstName'];
    lastName = widget.student['LastName'];
    course = widget.student['Course'];
    selectedYear = widget.student['Year'];
    enrolled = widget.student['Enrolled'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View/Edit/Delete Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: firstName,
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  firstName = value!;
                },
              ),
              TextFormField(
                initialValue: lastName,
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  lastName = value!;
                },
              ),
              TextFormField(
                initialValue: course,
                decoration: InputDecoration(labelText: 'Course'),
                onSaved: (value) {
                  course = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedYear,
                decoration: InputDecoration(labelText: 'Year'),
                items: <String>['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year']
                    .map((String year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Enrolled'),
                value: enrolled,
                onChanged: (value) {
                  setState(() {
                    enrolled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        widget.onUpdate({
                          'FirstName': firstName,
                          'LastName': lastName,
                          'Course': course,
                          'Year': selectedYear,
                          'Enrolled': enrolled
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onDelete();
                      Navigator.pop(context);
                    },
                    child: Text('Delete'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

