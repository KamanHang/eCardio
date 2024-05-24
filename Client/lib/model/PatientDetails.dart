class PatientDetails {
  int? patientId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? password;
  String? imagepath;

  PatientDetails(
      {this.patientId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.password,
      this.imagepath});

  PatientDetails.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    imagepath = json['imagepath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['imagepath'] = this.imagepath;
    return data;
  }
}
