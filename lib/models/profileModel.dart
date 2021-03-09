import 'dart:convert';

// ProfileModel profileFromJson(String str) {
//   final jsonData = json.decode(str);
//   return ProfileModel.fromMap(jsonData);
// }

// String profileToJson(ProfileModel data) {
//   final dyn = data.toMap();
//   return json.encode(dyn);
// }

class ProfileModel {
  String lastName;
  String firstName;
  String patronymic;
  String email;
  String phone;
  int sex;
  String category;

  ProfileModel(
      {this.lastName,
      this.firstName,
      this.patronymic,
      this.email,
      this.phone,
      this.sex,
      this.category});

  // factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
  //       id: json["id"],
  //       lastName: json["last_name"],
  //       firstName: json["first_name"],
  //       patronymic: json["patronymic"],
  //       email: json["email"],
  //       phone: json["phone"],
  //       sex: json["sex"],
  //       category: json['category'],
  //     );

  factory ProfileModel.fromMapUserData(
          Map<String, dynamic> lastName,
          Map<String, dynamic> firstName,
          Map<String, dynamic> patronymic,
          Map<String, dynamic> email,
          Map<String, dynamic> phone,
          Map<String, dynamic> sex,
          Map<String, dynamic> category) =>
      ProfileModel(
        lastName: lastName['value'],
        firstName: firstName['value'],
        patronymic: patronymic['value'],
        email: email['value'],
        phone: phone['value'],
        sex: int.parse(sex['value']),
        category: category['value'],
      );

  // Map<String, dynamic> toMap() => {
  //       "id": id,
  //       'last_name': lastName,
  //       "first_name": firstName,
  //       "patronymic": patronymic,
  //       "email": email,
  //       "phone": phone,
  //       "sex": sex,
  //       "category": category,
  //       "transfer_status": transferStatus,
  //     };

  Map<String, dynamic> toMapLastName() => {
        "key": "lastName",
        "value": lastName,
      };
  Map<String, dynamic> toMapFirstName() => {
        "key": "firstName",
        "value": firstName,
      };
  Map<String, dynamic> toMapPatronymic() => {
        "key": "patronymic",
        "value": patronymic,
      };
  Map<String, dynamic> toMapEmail() => {
        "key": "email",
        "value": email,
      };
  Map<String, dynamic> toMapPhone() => {
        "key": "phone",
        "value": phone,
      };

  Map<String, dynamic> toMapSex() => {
        "key": "sex",
        "value": sex,
      };

  Map<String, dynamic> toMapCategory() => {
        "key": "category",
        "value": category,
      };

  String get fullName {
    return this.lastName + " " + this.firstName + " " + this.patronymic;
  }
}
