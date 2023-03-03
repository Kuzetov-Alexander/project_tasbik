import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/widgets/import_file.dart';

class ButtonSaveDhikr extends StatefulWidget {
  const ButtonSaveDhikr({super.key});

  @override
  State<ButtonSaveDhikr> createState() => _ButtonSaveDhikrState();
}

class _ButtonSaveDhikrState extends State<ButtonSaveDhikr> {
  ////////////////////////////////////////////
  void funcOnPressedSave(BuildContext context) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => const SaveAlertDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('--------new build ButtonSaveDhikr');
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xffFFFFFF)),
        fixedSize: MaterialStateProperty.all(
            Size(mapperOrientation(portrait: 91.w, landscape: 208.w), 5.5.h)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        funcOnPressedSave(context);
      },
      child: const Text(
        'Save Dhikr',
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff4664FF)),
      ),
    );
  }
}
