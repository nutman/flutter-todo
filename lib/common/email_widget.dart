import 'package:flutter/material.dart';
import '../utils/utils.dart'; // Import your validation utility here

class EmailWidget extends StatefulWidget {
  final String email;
  final ValueChanged<String> onEmailChanged;

  const EmailWidget(
      {super.key, required this.email, required this.onEmailChanged});

  @override
  EmailWidgetState createState() => EmailWidgetState();
}

class EmailWidgetState extends State<EmailWidget> {
  bool touched = false;
  bool valid = true;

  void update(String value) {
    setState(() {
      widget.onEmailChanged(value);
      touched = true;
    });
  }

  bool checkValidity() {
    setState(() {
      valid = isEmailValid(_emailController.text);
    });
    touched = true;
    return valid;
  }

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF000000),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            hintText: 'Email',
            filled: true,
            fillColor: touched
                ? !valid
                    ? Colors.red[50]
                    : Colors.green[50]
                : Colors.white,
            errorText: touched && !valid ? 'Invalid Email' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          // onChanged: update,
        ));
  }
}
