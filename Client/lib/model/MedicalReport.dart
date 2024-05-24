class MedicalReportModel {
  int? reportId;
  int? patientId;
  String? test;
  String? result;
  String? refrange;
  String? reportdate;

  MedicalReportModel(
      {this.reportId,
      this.patientId,
      this.test,
      this.result,
      this.refrange,
      this.reportdate});

  MedicalReportModel.fromJson(Map<String, dynamic> json) {
    reportId = json['report_id'];
    patientId = json['patient_id'];
    test = json['test'];
    result = json['result'];
    refrange = json['refrange'];
    reportdate = json['reportdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_id'] = this.reportId;
    data['patient_id'] = this.patientId;
    data['test'] = this.test;
    data['result'] = this.result;
    data['refrange'] = this.refrange;
    data['reportdate'] = this.reportdate;
    return data;
  }
}
