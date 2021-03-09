import 'package:authApp/db/db_helper.dart';
import 'package:authApp/models/profileModel.dart';
import 'package:authApp/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";
  final GlobalKey<FormState> _formKey = GlobalKey();
  // Map<String, String> _authData = {
  //   'email': '',
  //   'password': '',
  //   'lastName': '',
  //   'firstName': '',
  //   'patronymic': '',
  //   'phone': '',
  //   'category': ''
  // };
  ProfileModel _profile = ProfileModel(
      lastName: "",
      firstName: "",
      patronymic: "",
      email: "",
      phone: "",
      sex: null,
      category: null);
  int _sex;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+###########', filter: {"#": RegExp(r'[0-9]')});

  InputDecoration _decorationField(String labelText) {
    return InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 1.0)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        errorStyle: TextStyle(color: Colors.blueGrey),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.blueGrey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ваш профиль"),
          actions: [
            IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(_profile.fullName);
                  DbHelper.db.updateProfileData(_profile);
                  //  Navigator.of(context).pushNamed(MainScreen.routeName);
                  // Scaffold.of(context).showSnackBar(
                  //     SnackBar(content: Text("Успешно обновлено!")));
                })
          ],
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: DbHelper.db.readProfileData(),
                builder: (BuildContext context,
                    AsyncSnapshot<ProfileModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blueGrey,
                            decoration: _decorationField("Фамилия"),
                            controller: TextEditingController(
                                text: snapshot.data.lastName),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле не должно быть пустым';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _profile.lastName = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blueGrey,
                            decoration: _decorationField("Имя"),
                            controller: TextEditingController(
                                text: snapshot.data.firstName),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле не должно быть пустым';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _profile.firstName = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blueGrey,
                            decoration: _decorationField("Отчество"),
                            controller: TextEditingController(
                                text: snapshot.data.patronymic),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле не должно быть пустым';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _profile.patronymic = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blueGrey,
                            decoration: _decorationField("E-mail"),
                            controller: TextEditingController(
                                text: snapshot.data.email),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty || !value.contains("@")) {
                                return 'Не правильный формат';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _profile.email = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.blueGrey,
                            inputFormatters: [maskFormatter],
                            decoration: _decorationField("Номер телефона"),
                            controller: TextEditingController(
                                text: snapshot.data.phone),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле не должно быть пустым';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _profile.phone = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Укажите Ваш пол';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _profile.sex = value;
                            },
                            value: snapshot.data.sex,
                            iconEnabledColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            dropdownColor: Colors.white,
                            decoration: _decorationField("Ваш пол"),
                            onChanged: (value) {
                              _profile.sex = value;
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text("Мужской"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Женский"),
                                value: 2,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'Укажите категорию';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _profile.category = value;
                            },
                            value: snapshot.data.category,
                            iconEnabledColor: Colors.white,
                            style: TextStyle(color: Colors.black),
                            dropdownColor: Colors.white,
                            decoration: _decorationField("Ваша категория"),
                            onChanged: (value) {
                              _profile.category = value;
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text("Собственник/Дольщик"),
                                value: "owner",
                              ),
                              DropdownMenuItem(
                                child: Text("Другая категория"),
                                value: "other",
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      heightFactor: 3.0,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueGrey,
                      ),
                    );
                  }
                },
              ),
            )));
  }
}
