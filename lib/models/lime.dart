class Lime {
  String? message;
  String? limeGradeID;
  String? Aplus;
  String? A;
  String? Bplus;
  String? B;
  String? Cplus;
  String? C;
  String? D;
  String? limeAddDate;

  Lime(
      {this.message,
      this.limeGradeID,
      this.Aplus,
      this.A,
      this.Bplus,
      this.B,
      this.Cplus,
      this.C,
      this.D,
      this.limeAddDate});

  Lime.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    limeGradeID = json['limeGradeID'];
    Aplus = json['Aplus']?.toString();
    A = json['A']?.toString();
    Bplus = json['Bplus']?.toString();
    B = json['B']?.toString();
    Cplus = json['Cplus']?.toString();
    C = json['C']?.toString();
    D = json['D']?.toString();
    limeAddDate = json['limeAddDate']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['limeGradeID'] = this.limeGradeID;
    data['Aplus'] = this.Aplus;
    data['A'] = this.A;
    data['Bplus'] = this.Bplus;
    data['B'] = this.B;
    data['Cplus'] = this.Cplus;
    data['C'] = this.C;
    data['D'] = this.D;
    data['limeAddDate'] = this.limeAddDate;
    return data;
  }
}