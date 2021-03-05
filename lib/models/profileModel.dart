import 'dart:convert';

ProfileModel profileFromJson(String str) {
  final jsonData = json.decode(str);
  return ProfileModel.fromMap(jsonData);
}

String profileToJson(ProfileModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ProfileModel {
  int id;
  String lastName;
  String firstName;
  String patronymic;
  String email;
  String phone;
  int sex;
  String category;
  int transferStatus = 0;

  ProfileModel(
      {this.id,
      this.lastName,
      this.firstName,
      this.patronymic,
      this.email,
      this.phone,
      this.sex,
      this.category});

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        lastName: json["last_name"],
        firstName: json["first_name"],
        patronymic: json["patronymic"],
        email: json["email"],
        phone: json["phone"],
        sex: json["sex"],
        category: json['category'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        'last_name': lastName,
        "first_name": firstName,
        "patronymic": patronymic,
        "email": email,
        "phone": phone,
        "sex": sex,
        "category": category,
        "transfer_status": transferStatus,
      };

  String get fullName {
    return this.lastName + " " + this.firstName + " " + this.patronymic;
  }
}
