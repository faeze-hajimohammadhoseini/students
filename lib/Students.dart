class Students {
  final String firstName;
  final String lastName;

  Students({this.firstName, this.lastName});

  factory Students.fromJson(Map<String, dynamic> json) {
    return new Students(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,

    );
  }

}