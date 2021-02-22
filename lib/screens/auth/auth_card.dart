import 'package:authApp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({Key key}) : super(key: key);
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'lastName': '',
    'firstName': '',
    'patronymic': '',
    'phone': '',
    'category': ''
  };
  var _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _patronymicController = TextEditingController();
  final _phoneController = TextEditingController();
  int _sex;

  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(microseconds: 300));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Нет подклюения к сети!"),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Продолжить"))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return; //@todo
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Signup) {
        await Provider.of<AuthProvider>(context, listen: false).signup(
            _authData['email'],
            _authData['password'],
            _authData['phone'],
            _authData['lastName'],
            _authData['firstName'],
            _authData['patronymic'],
            _sex,
            _authData['category']);
      } else {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      }
    } catch (error) {
      const errorMessage =
          'Не удалось авторизоваться! Проверьте, пожалуйста, Интернет-соединение!';
      _showErrorDialog(errorMessage);
    }

    final myError = Provider.of<AuthProvider>(context).serverError;
    if (myError != null) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(myError)));
    }

    setState(() {
      _isLoading = false;
    });
  }

  /// Здесь остановилось обучение
  ///
  ///
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  InputDecoration _decorationField(String labelText) {
    return InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 1.0)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        errorStyle: TextStyle(color: Colors.white),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0)));
  }

  @override
  Widget build(Object context) {
    final deviceSize = MediaQuery.of(context).size;
    var maskFormatter = new MaskTextInputFormatter(
        mask: '+###########', filter: {"#": RegExp(r'[0-9]')});
    return Container(
      height: deviceSize.height,
      color: Colors.transparent,
      //shape: RoundedRectangleBorder(
      //  borderRadius: BorderRadius.circular(10.0),
      // ),
      //elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 320 : 260,
        // height: _heightAnimation.value.height,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.95,
        // width: 400,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: _decorationField("Введите e-mail"),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Неправильный адрес электронной почты!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: _decorationField("Введите пароль"),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Минимум 5 символов!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 613 : 0,
                  ),
                  duration: Duration(milliseconds: 10),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: _repeatPasswordController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              enabled: _authMode == AuthMode.Signup,
                              decoration:
                                  _decorationField("Введите пароль повторно"),
                              obscureText: true,
                              validator: (_) {
                                if (_passwordController.value !=
                                        _repeatPasswordController.value &&
                                    _authMode == AuthMode.Signup) {
                                  return "Пароли не совпадают!";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [maskFormatter],
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration:
                                  _decorationField("Введите номер телефона"),
                              validator: (value) {
                                if (value.isEmpty &&
                                    value.length < 12 &&
                                    _authMode == AuthMode.Signup) {
                                  return 'Неправильный номер телефона.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['phone'] = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: _lastNameController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              enabled: _authMode == AuthMode.Signup,
                              decoration: _decorationField("Ваша фамилия"),
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value.isEmpty) {
                                        return 'Введите Вашу фамилию!';
                                      }
                                      return null;
                                    }
                                  : null,
                              onSaved: (value) {
                                _authData['lastName'] = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: _firstNameController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              enabled: _authMode == AuthMode.Signup,
                              decoration: _decorationField("Ваше имя"),
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value.isEmpty) {
                                        return 'Введите Ваше имя!';
                                      }
                                      return null;
                                    }
                                  : null,
                              onSaved: (value) {
                                _authData['firstName'] = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: _patronymicController,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              enabled: _authMode == AuthMode.Signup,
                              decoration: _decorationField("Ваше отчество"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DropdownButtonFormField(
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value == null) {
                                        return 'Укажите Ваш пол';
                                      }
                                      return null;
                                    }
                                  : null,
                              onSaved: (value) {
                                _sex = value;
                              },
                              iconEnabledColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              dropdownColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.75),
                              decoration: _decorationField("Ваш пол"),
                              onChanged: (value) {
                                _sex = value;
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
                              validator: _authMode == AuthMode.Signup
                                  ? (value) {
                                      if (value == null) {
                                        return 'Введите категорию, к которой Вы относитесь!';
                                      }
                                      return null;
                                    }
                                  : null,
                              onSaved: (value) {
                                _authData['category'] = value;
                              },
                              iconEnabledColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              dropdownColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.75),
                              decoration:
                                  _decorationField("Выберите категорию"),
                              onChanged: (value) {
                                _authData['category'] = value;
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text("Собственник/Дольщик"),
                                  value: 'owner',
                                ),
                                DropdownMenuItem(
                                  child: Text("Другая категория"),
                                  value: 'other',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(
                        _authMode == AuthMode.Login ? 'Войти' : 'Регистрация',
                        style: Theme.of(context).primaryTextTheme.bodyText2),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'Регистрация' : 'Войти'}'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
