import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/widgets/import_file.dart';
import 'package:tasbix/widgets/provider.dart';

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
  Widget build(BuildContext context) {
    Dhikr dhikr = context.watch<IntProvider>().listDhikr[widget.index];
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      elevation: 24,
      title: const Text(
        'Edit counter and Title',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _counterEditController,
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
              labelText: 'Counter Dhikr',
            ),
          ),
          SizedBox(height: 2.w),
          TextFormField(
            controller: _titleEditController,
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

            setState(() {});
            Navigator.pop(context);
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
    );
  }
}
