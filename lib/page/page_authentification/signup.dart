import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/style_text.dart';
import 'package:tasbix/page/page_authentification/widget/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isHiddenPassword = true;
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  String _password = '';

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

  void backPage() {
    setState(() {
      login().then(
        (value) => context.pop(),
      );
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  Future<void> login() async {
    // emailController.text = 'akuzetovip@gmail.com';
    // _password = 'Qazwsxedc1!';
    // passwordController.text = _password;

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          'Неправильный email или пароль. Повторите попытку',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
        return;
      }
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
                    Text('Login', style: MyStyle.styleTextBlue),
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
                                context, emailFocus, passwordFocus);
                          },
                          focusNode: emailFocus,
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
                            labelText: 'Enter email',
                            labelStyle: const TextStyle(
                              color: Color(0xff4664FF),
                            ),
                          ),
                          validator: emailValidator,
                        ),
                        SizedBox(height: 8.w),
                        TextFormField(
                          focusNode: passwordFocus,
                          onFieldSubmitted: (_) {
                            _fieldFocusChange(
                                context, passwordFocus, passwordFocus);
                          },
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
                            labelText: 'Enter password',
                            labelStyle: const TextStyle(
                              color: Color(0xff4664FF),
                            ),
                          ),
                          onChanged: (value) => _password = value,
                          validator: passwordValidator,
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
                                login();
                                backPage();
                              },
                              child:
                                  Text('Login', style: MyStyle.styleTextBlue)),
                        ),
                        SizedBox(height: 4.w),
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
                                context.go('/resetpass');
                              },
                              child: Text('Reset password',
                                  style: MyStyle.styleTextBlue)),
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
