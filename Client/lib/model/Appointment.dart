class AppointmentModel {
  int? appointmentId;
  String? appointmentType;
  String? appointmentDate;
  String? appointmentTime;
  int? patientId;
  int? doctorId;
  String? weekDay;
  String? patientName;
  String? doctorName;
  String? patientEmail;

  AppointmentModel(
      {this.appointmentId,
      this.appointmentType,
      this.appointmentDate,
      this.appointmentTime,
      this.patientId,
      this.doctorId,
      this.weekDay,
      this.patientName,
      this.doctorName,
      this.patientEmail});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointment_id'];
    appointmentType = json['appointment_type'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    weekDay = json['week_day'];
    patientName = json['patient_name'];
    doctorName = json['doctor_name'];
    patientEmail = json['patient_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_id'] = this.appointmentId;
    data['appointment_type'] = this.appointmentType;
    data['appointment_date'] = this.appointmentDate;
    data['appointment_time'] = this.appointmentTime;
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['week_day'] = this.weekDay;
    data['patient_name'] = this.patientName;
    data['doctor_name'] = this.doctorName;
    data['patient_email'] = this.patientEmail;
    return data;
  }
}
