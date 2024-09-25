class StudentsModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  const StudentsModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory StudentsModel.fromJson(Map<String, dynamic> json) {
    return StudentsModel(
      id: json['ID'] as int?,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      course: json['Course'] as String,
      year: json['Year'] as String,
      enrolled: json['Enrolled'] == 1,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Course': course,
      'Year': year,
      'Enrolled': enrolled ? 1 : 0,
    };
  }
}
