import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/style_text.dart';
import 'package:tasbix/page/page_authentification/widget/widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isHiddenPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  String _password = '';

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
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      // formKey.currentState!.save();

      debugPrint('---------------Number email: ${emailController.text}');
      debugPrint('---------------Number password: ${passwordController.text}');
      debugPrint(
          '---------------Confirm password: ${confirmPasswordController.text}');
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
            context, 'Такой Email уже используется', true);
        return;
      } else {
        SnackBarService.showSnackBar(context, 'Неизвестная ошибка', true);
      }
      debugPrint(e.code);
    } catch (e) {
      debugPrint('----------$e');
    }
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w, top: 1.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xff4664FF),
                        )),
                    Text(
                      'Registration',
                      style: MyStyle.styleTextBlue,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 3.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onFieldSubmitted: (_) {
                            _fieldFocusChange(
                                context, _emailFocus, _passwordFocus);
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
                                borderSide: BorderSide(
                                    color: Colors.grey.shade400, width: 2),
                              ),
                              labelText: 'Enter email'),
                          validator: emailValidator,
                        ),
                        SizedBox(height: 8.w),
                        TextFormField(
                          onFieldSubmitted: (_) {
                            _fieldFocusChange(
                                context, _passwordFocus, _confirmPasswordFocus);
                          },
                          focusNode: _passwordFocus,
                          autocorrect: false,
                          obscureText: _isHiddenPassword,
                          controller: passwordController,
                          decoration: InputDecoration(
                              suffix: InkWell(
                                child: Icon(_isHiddenPassword
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
                                borderSide: BorderSide(
                                    color: Colors.grey.shade400, width: 2),
                              ),
                              labelText: 'Enter password'),
                          onChanged: (value) => _password = value,
                          validator: passwordValidator,
                        ),
                        SizedBox(height: 8.w),
                        TextFormField(
                          focusNode: _confirmPasswordFocus,
                          autocorrect: false,
                          obscureText: _isHiddenPassword,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                              suffix: InkWell(
                                child: Icon(_isHiddenPassword
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
                                borderSide: BorderSide(
                                    color: Colors.grey.shade400, width: 2),
                              ),
                              labelText: 'Enter correct password'),
                          validator: (value) => MatchValidator(
                                  errorText: 'passwords do not match')
                              .validateMatch(value!, _password),
                        ),
                        SizedBox(height: 8.w),
                        SizedBox(
                          width: double.infinity,
                          height: 16.w,
                          child: TextButton(
                              style: ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                side: MaterialStateProperty.all(
                                    const BorderSide(
                                        color: Color(0xff4664FF), width: 2)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                emailController.text = 'uraltools96@mail.ru';
                                // emailController.text = 'ip.stolets@yandex.ru';
                                _password = 'Qazwsxedc1!';
                                passwordController.text = _password;
                                confirmPasswordController.text = 'Qazwsxedc1!';
                                _submitForm().then((value) {
                                  setState(() {
                                    context.go('/verifymail');
                                  });
                                });
                              },
                              child: Text(
                                'Registration',
                                style: MyStyle.styleTextBlue,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
