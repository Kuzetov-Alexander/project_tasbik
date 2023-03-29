import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/style_text.dart';
import 'package:tasbix/page/page_authentification/widget/widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    final scaffoldMassager = ScaffoldMessenger.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailTextInputController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showSnackBar(
          context,
          'Такой email незарегистрирован!',
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

    const snackBar = SnackBar(
      content: Text('Сброс пароля осуществен. Проверьте почту'),
      backgroundColor: Colors.green,
    );

    scaffoldMassager.showSnackBar(snackBar);
    void back() {
      setState(() {
        context.pop();
      });
    }

    back();
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
                    Text('Reset password', style: MyStyle.styleTextBlue),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 3.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          controller: emailTextInputController,
                          validator: emailValidator,
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
                              onPressed: resetPassword,
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
