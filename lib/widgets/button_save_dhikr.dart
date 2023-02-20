import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'package:tasbix/widgets/small_container.dart';

class ButtonSaveDhikr extends StatefulWidget {
  const ButtonSaveDhikr({super.key});

  @override
  State<ButtonSaveDhikr> createState() => _ButtonSaveDhikrState();
}

class _ButtonSaveDhikrState extends State<ButtonSaveDhikr> {
  final _titleDhikrController = TextEditingController();

  @override
  void dispose() {
    _titleDhikrController.dispose();
    super.dispose();
  }

  void funcOnPressedSave(BuildContext myContext) {
    showDialog<void>(
      barrierDismissible: false,
      context: myContext,
      builder: (myContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        elevation: 24,
        title: const Text(
          'Save Dhikr',
          textAlign: TextAlign.center,
        ),
        content: TextFormField(
          controller: _titleDhikrController,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
              borderSide: BorderSide(
                color: Colors.amber,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            labelText: 'Title Dhikr',
          ),
        ),
        actions: [
          FloatingActionButton(
            onPressed: () async {
              // var box = await Hive.openBox('myBox');
              // var id = DateTime.now().millisecondsSinceEpoch;
              // final prefs = await SharedPreferences.getInstance();
              // var counter =
              //     prefs.containsKey('counter') ? prefs.getInt('counter')! : 0;
              // box.put(
              //     id.toString(),
              //     Dhikr(
              //         title: _titleDhikrController.text,
              //         counter: counter,
              //         dateTime: DateTime.now()));

              void refresh() {
                myContext
                    .findRootAncestorStateOfType<SmallContainerState>()!
                    .proverka();
                Navigator.pop(context);
              }

              refresh();
            },
            backgroundColor: const Color(0xff4664FF),
            child: const Text('Save'),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: const Color(0xff4664FF),
            child: const Text('Back'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
