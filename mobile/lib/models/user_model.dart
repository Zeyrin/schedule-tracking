class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? role;
  String? manager;
  int? days;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.role,
      this.manager,
      this.days});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      role: map['role'],
      manager: map['manager'],
      days: map['days'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'role': role,
      'manager': manager,
      'days': days,
    };
  }
}
