import 'package:crud_activity/pages/update.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  const HomeCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  @override
  Widget build(BuildContext context) {
    // Define a reusable text style
    const TextStyle textStyle = TextStyle(fontSize: 14);

    return GestureDetector(
      child: Card(
        color: Colors.white70,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $lastName, $firstName',
                style: textStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text('Course: $course', style: textStyle),
              const SizedBox(height: 4),
              Text('Year: $year', style: textStyle),
              const SizedBox(height: 4),
              Text('Enrolled: ${enrolled ? "Yes" : "No"}', style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
