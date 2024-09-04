import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './common/email_widget.dart';
import './common/password_widget.dart';
import 'package:url_launcher/url_launcher.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<EmailWidgetState> _emailKey = GlobalKey<EmailWidgetState>();
  final GlobalKey<PasswordWidgetState> _passwordKey =
      GlobalKey<PasswordWidgetState>();

  String email = '';
  String password = '';

  void handleSubmit() {
    bool isEmailValid = _emailKey.currentState?.checkValidity() ?? false;
    bool isPasswordValid = _passwordKey.currentState?.checkValidity() ?? false;

    if (isEmailValid && isPasswordValid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Sign Up')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Center(child: Text('Validation passed')),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Link to repo',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(
                            Uri.https(
                              'github.com',
                              'nutman/flutter-todo',
                            ),
                          );
                        },
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'OK',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }

  final backGroundGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(244, 249, 255, 1),
        Color.fromRGBO(224, 237, 251, 1)
      ]);

  final buttonGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromRGBO(112, 195, 255, 1),
        Color.fromRGBO(75, 101, 255, 1)
      ]);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: backGroundGradient,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    'Sign up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 28,
                        color: Color(0xff4a4d71),
                        fontFamily: 'Inter-Bold',
                        fontWeight: FontWeight.normal),
                    maxLines: 9999,
                    overflow: TextOverflow.ellipsis,
                  )),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EmailWidget(
                      key: _emailKey,
                      email: email,
                      onEmailChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    PasswordWidget(
                      key: _passwordKey,
                      password: password,
                      onPasswordChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: handleSubmit,
                        style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(0.0)),
                        ),
                        child: Ink(
                          padding: const EdgeInsets.only(
                              left: 90, top: 17, right: 90, bottom: 17),
                          decoration: BoxDecoration(
                              gradient: buttonGradient,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            child: const Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  height: 1,
                                  fontSize: 16,
                                  color: const Color(0xffffffff),
                                  fontFamily: 'Inter-Bold',
                                  fontWeight: FontWeight.bold),
                              maxLines: 9999,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
