import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isHiddenPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  String password = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
    BuildContext context,
    FocusNode currentfocus,
    FocusNode nextFocus,
  ) {
    currentfocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _passwordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.montserrat(
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
          bodyMedium: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          labelLarge: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xff4664FF)),
          ),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xff4664FF),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('Registration'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(context, _emailFocus, _passwordFocus);
                  },
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  controller: emailController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xff4664FF),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(24),
                        ),
                        borderSide:
                            BorderSide(color: Colors.blue.shade200, width: 2),
                      ),
                      labelText: 'Enter email'),
                  validator: emailValidator,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  onFieldSubmitted: (_) {
                    _fieldFocusChange(
                        context, _passwordFocus, _confirmPasswordFocus);
                  },
                  focusNode: _passwordFocus,
                  autocorrect: false,
                  obscureText: isHiddenPassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                      suffix: InkWell(
                        child: Icon(isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onTap: () {
                          _passwordView();
                        },
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xff4664FF),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(24),
                        ),
                        borderSide:
                            BorderSide(color: Colors.blue.shade200, width: 2),
                      ),
                      labelText: 'Enter password'),
                  onChanged: (value) => password = value,
                  validator: passwordValidator,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  focusNode: _confirmPasswordFocus,
                  autocorrect: false,
                  obscureText: isHiddenPassword,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      suffix: InkWell(
                        child: Icon(isHiddenPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onTap: () {
                          _passwordView();
                        },
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xff4664FF),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(24),
                        ),
                        borderSide:
                            BorderSide(color: Colors.blue.shade200, width: 2),
                      ),
                      labelText: 'Enter correct password'),
                  validator: (value) =>
                      MatchValidator(errorText: 'passwords do not match')
                          .validateMatch(value!, password),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff4664FF)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Registration')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      debugPrint('---------------Number email: ${emailController.text}');
      debugPrint('---------------Number password: ${passwordController.text}');
      debugPrint(
          '---------------Confirm password: ${confirmPasswordController.text}');
      // SnackBarService.showSnackBar(context, 'Repeat enter password', true);
      // return;
    }
  }
}

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(
    r'(?=.*?[#?!@$%^&*()_])',
    errorText: 'passwords must have at least one special character',
  )
]);

final emailValidator = MultiValidator([
  EmailValidator(errorText: 'Error Text'),
]);

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

abstract class MyStyle {
  const MyStyle._();

  static TextStyle styleTextGreen = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.green,
  );

  static TextStyle styleTextBlue = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.blue.shade200,
  );

  static TextStyle styleTextWhite = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle styleTextValidator =
      GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w400);

  static TextStyle styleTextW7 =
      GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle styleText =
      GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle styleTextSmall =
      GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600);
}
