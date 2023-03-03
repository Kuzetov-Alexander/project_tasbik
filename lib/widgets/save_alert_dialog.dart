import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasbix/widgets/provider.dart';

class SaveAlertDialog extends StatefulWidget {
  const SaveAlertDialog({
    super.key,
  });

  @override
  State<SaveAlertDialog> createState() => _SaveAlertDialogState();
}

class _SaveAlertDialogState extends State<SaveAlertDialog> {
  final _titleDhikrController = TextEditingController();
  @override
  void dispose() {
    _titleDhikrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
          onPressed: () {
            context
                .read<IntProvider>()
                .addDhikrInHive(_titleDhikrController.text);
            context.read<IntProvider>().getObjectFromHive();
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