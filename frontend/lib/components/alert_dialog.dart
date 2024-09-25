import 'package:crud_activity/api_service/student_service.dart';
import 'package:crud_activity/pages/home.dart';
import 'package:flutter/material.dart';

class DialogAlertBox extends StatelessWidget {
  final int? id;
  const DialogAlertBox({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                "Are you sure you want to delete this record?",
                style: TextStyle(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await apiService.deleteStudentData(id: id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Student Deleted Successfully')),
                        );
                        Navigator.pop(context, true);
                        
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $error')),
                        );
                      }
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
