import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SnackBarService {
  static const errorColor = Colors.red;
  static const okColor = Colors.green;

  static Future<void> showSnackBar(
      BuildContext context, String message, bool error) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: error ? errorColor : okColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*()_])',
        errorText: 'passwords must have at least one special character'),
  ],
);

final emailValidator = MultiValidator(
  [EmailValidator(errorText: 'Error Text')],
);
