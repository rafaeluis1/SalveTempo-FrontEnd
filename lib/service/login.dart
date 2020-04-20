class Login {
  String emailuser;
  String password;

  Login({this.emailuser, this.password});

  Login.fromJson(Map<String, dynamic> json) {
    emailuser = json['emailuser'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailuser'] = this.emailuser;
    data['password'] = this.password;
    return data;
  }
}
