class Lime {
  String? message;
  String? limeGradeID;
  String? aplus;
  String? a;
  String? bplus;
  String? b;
  String? cplus;
  String? c;
  String? d;
  String? limeAddDate;

  Lime(
      {this.message,
      this.limeGradeID,
      this.aplus,
      this.a,
      this.bplus,
      this.b,
      this.cplus,
      this.c,
      this.d,
      this.limeAddDate});

  Lime.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    limeGradeID = json['limeGradeID'];
    aplus = json['Aplus'];
    a = json['A'];
    bplus = json['Bplus'];
    b = json['B'];
    cplus = json['Cplus'];
    c = json['C'];
    d = json['D'];
    limeAddDate = json['limeAddDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['limeGradeID'] = this.limeGradeID;
    data['Aplus'] = this.aplus;
    data['A'] = this.a;
    data['Bplus'] = this.bplus;
    data['B'] = this.b;
    data['Cplus'] = this.cplus;
    data['C'] = this.c;
    data['D'] = this.d;
    data['limeAddDate'] = this.limeAddDate;
    return data;
  }
}