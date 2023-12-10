
import 'dart:convert';

List<DoctorModel> doctorModelFromJson(String str) => List<DoctorModel>.from(json.decode(str).map((x) => DoctorModel.fromJson(x)));

String doctorModelToJson(List<DoctorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorModel {
    int doctorId;
    String firstName;
    String lastName;
    String email;
    String designation;
    String location;
    String workingTime;
    String description;
    String phoneNumber;
    String rating;
    String image;

    DoctorModel({
        required this.doctorId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.designation,
        required this.location,
        required this.workingTime,
        required this.description,
        required this.phoneNumber,
        required this.rating,
        required this.image,
    });

    factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        doctorId: json["doctor_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        designation: json["designation"],
        location: json["location"],
        workingTime: json["working_time"],
        description: json["description"],
        phoneNumber: json["phone_number"],
        rating: json["rating"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "designation": designation,
        "location": location,
        "working_time": workingTime,
        "description": description,
        "phone_number": phoneNumber,
        "rating": rating,
        "image": image,
    };
}
