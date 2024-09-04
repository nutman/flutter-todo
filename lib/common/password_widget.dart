import 'package:flutter/material.dart';

class PasswordWidget extends StatefulWidget {
  final String password;
  final ValueChanged<String> onPasswordChanged;

  const PasswordWidget(
      {super.key, required this.password, required this.onPasswordChanged});

  @override
  PasswordWidgetState createState() => PasswordWidgetState();
}

class PasswordWidgetState extends State<PasswordWidget> {
  bool showPassword = false;
  bool touched = false;
  bool valid = true;

  bool hasEightCharactersAndHasNoSpaces = false;
  bool hasUppercaseAndLowercase = false;
  bool hasDigit = false;

  void update(String value) {
    setState(() {
      widget.onPasswordChanged(value);
      touched = true;
      validatePassword(value);
    });
  }

  bool checkValidity() {
    setState(() {
      valid = validatePassword(_passwordController.text);
    });
    touched = true;
    return valid;
  }

  bool validatePassword(String value) {
    setState(() {
      hasEightCharactersAndHasNoSpaces =
          value.length >= 8 && value.length <= 64 && !value.contains(' ');
      hasUppercaseAndLowercase =
          value.contains(RegExp(r'[A-Z]')) && value.contains(RegExp(r'[a-z]'));
      hasDigit = value.contains(RegExp(r'\d'));

      valid = hasEightCharactersAndHasNoSpaces &&
          hasUppercaseAndLowercase &&
          hasDigit;
    });

    return valid;
  }

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _passwordController,
          obscureText: !showPassword,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF000000),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            hintText: 'Create your password',
            suffixIcon: IconButton(
              icon:
                  Icon(showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),
            filled: true,
            fillColor: touched
                ? !valid
                    ? Colors.red[50]
                    : Colors.green[50]
                : Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '8 characters or more (no spaces)',
                style: TextStyle(
                  color: touched
                      ? (hasEightCharactersAndHasNoSpaces
                          ? Colors.green
                          : Colors.red)
                      : Colors.black,
                ),
              ),
              Text(
                'Uppercase and lowercase letters',
                style: TextStyle(
                  color: touched
                      ? (hasUppercaseAndLowercase ? Colors.green : Colors.red)
                      : Colors.black,
                ),
              ),
              Text(
                'At least one digit',
                style: TextStyle(
                  color: touched
                      ? (hasDigit ? Colors.green : Colors.red)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
