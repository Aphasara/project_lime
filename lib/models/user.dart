class User {
  String? message;
  String? userId;
  String? userFullname;
  String? userName;
  String? userPassword;
  String? userImage;
  String? userCreatedDate;

  User({
    this.message,
    this.userId,
    this.userFullname,
    this.userName,
    this.userPassword,
    this.userImage,
    this.userCreatedDate,
  });

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    userFullname = json['userFullname'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
    userCreatedDate = json['userCreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['userFullname'] = this.userFullname;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    data['userCreatedDate'] = this.userCreatedDate;
    return data;
  }
}
