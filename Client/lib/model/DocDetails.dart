class DocModel {
  int? doctorId;
  String? firstName;
  String? lastName;
  String? email;
  String? designation;
  String? location;
  String? workingTime;
  String? description;
  String? phoneNumber;
  String? rating;
  String? image;
  String? password;

  DocModel(
      {this.doctorId,
      this.firstName,
      this.lastName,
      this.email,
      this.designation,
      this.location,
      this.workingTime,
      this.description,
      this.phoneNumber,
      this.rating,
      this.image,
      this.password});

  DocModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    designation = json['designation'];
    location = json['location'];
    workingTime = json['working_time'];
    description = json['description'];
    phoneNumber = json['phone_number'];
    rating = json['rating'];
    image = json['image'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['location'] = this.location;
    data['working_time'] = this.workingTime;
    data['description'] = this.description;
    data['phone_number'] = this.phoneNumber;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['password'] = this.password;
    return data;
  }
}
