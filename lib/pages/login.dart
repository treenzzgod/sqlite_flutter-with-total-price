import 'package:flutter/material.dart';
import 'package:sqlite_flutter/db/dbhelper.dart';
import 'package:sqlite_flutter/widget/genLoginSignupHeader.dart';
import 'package:sqlite_flutter/widget/genTextFormField.dart';
import 'package:quickalert/quickalert.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final DbHelper dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> form = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: form,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Login'),
                  getTextFormField(
                      inputType: TextInputType.text,
                      controller: usernameController,
                      icon: Icons.person,
                      hintName: 'Username'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    inputType: TextInputType.text,
                    controller: passwordController,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (form.currentState!.validate()) {
                          final username = usernameController.text;
                          final password = passwordController.text;
                        }
                        final sukses = await dbHelper.login(
                            usernameController.text, passwordController.text);

                        if (sukses) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Login Berhasil',
                            text: 'Selamat Datang',
                            titleColor: Colors.white,
                            textColor: Colors.black,
                            confirmBtnText: 'Oke',
                            onConfirmBtnTap: () {
                              Navigator.pushNamed(context, '/home');
                            },
                          );
                        } else {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Login Gagal',
                              text: 'Username atau Password Salah',
                              titleColor: Colors.white,
                              textColor: Colors.black,
                              confirmBtnText: 'Oke',
                              onConfirmBtnTap: () {
                                Navigator.pop(context);
                              });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[400],
                        minimumSize: Size(
                          10,
                          50,
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
