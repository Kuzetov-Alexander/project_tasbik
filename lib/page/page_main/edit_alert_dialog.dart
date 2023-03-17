import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'package:tasbix/import.dart';

class EditAlertDialog extends StatefulWidget {
  const EditAlertDialog({super.key, required this.index});

  final int index;

  @override
  State<EditAlertDialog> createState() => _EditAlertDialogState();
}

class _EditAlertDialogState extends State<EditAlertDialog> {
  final _titleEditController = TextEditingController();
  final _counterEditController = TextEditingController();

  @override
  void dispose() {
    _titleEditController.dispose();
    _counterEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dhikr dhikr = context.read<IntProvider>().listDhikr[widget.index];
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      elevation: 24,
      title: const Text(
        LocaleKeys.editTitleDhikr,
        textAlign: TextAlign.center,
      ).tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _counterEditController,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
                borderSide: BorderSide(
                  color: Color(0xff4664FF),
                  width: 2,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              labelText: LocaleKeys.counterDhikr.tr(),
            ),
          ),
          SizedBox(height: 2.w),
          TextFormField(
            controller: _titleEditController,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
                borderSide: BorderSide(
                  color: Color(0xff4664FF),
                  width: 2,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              labelText: LocaleKeys.titleDhikr.tr(),
            ),
          ),
        ],
      ),
      actions: [
        FloatingActionButton(
          onPressed: () async {
            Box<Dhikr> box = Hive.box('myBox');
            dhikr.counter = int.parse(_counterEditController.text);
            dhikr.title = _titleEditController.text;
            dhikr.dateTime = DateTime.now();

            box.put(
                box.keys.toList()[widget.index].toString(),
                Dhikr(
                    title: _titleEditController.text,
                    counter: int.parse(_counterEditController.text),
                    dateTime: DateTime.now()));

            context.read<IntProvider>().getObjectFromHive();

            Navigator.pop(context);
          },
          backgroundColor: const Color(0xff4664FF),
          child: Text(LocaleKeys.saveButton.tr()),
        ),
        FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: const Color(0xff4664FF),
          child: Text(LocaleKeys.backButton.tr()),
        )
      ],
    );
  }
}
