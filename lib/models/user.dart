class User {
  String? message;
  String? user_Id;
  String? userFullName;
  String? userName;
  String? userPassword;
  String? userImage;
  String? userCreatedDate;

  User({
    this.message,
    this.user_Id,
    this.userFullName,
    this.userName,
    this.userPassword,
    this.userImage,
    this.userCreatedDate,
  });

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user_Id = json['user_Id'];
    userFullName = json['userFullName'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
    userCreatedDate = json['userCreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_Id'] = this.user_Id;
    data['userFullName'] = this.userFullName;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    data['userCreatedDate'] = this.userCreatedDate;
    return data;
  }
}
