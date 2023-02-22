import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/method_orientation.dart';
import 'import_file.dart';

class SmallContainer extends StatefulWidget {
  const SmallContainer({super.key});

  @override
  State<SmallContainer> createState() => SmallContainerState();
}

class SmallContainerState extends State<SmallContainer> {
  final _titleDhikrController = TextEditingController();
  final _counterDhikrController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('new build smallContainer');
  }

  void proverka() {
    print('proverka SmallContainer');
  }

  refreshState() {
    print('refresh state SmallContainer');
    setState(() {});
  }

  Future<Widget> getObjectFromHive() async {
    var box = await Hive.openBox('myBox');
    if (box.keys.isEmpty) {
      return const Text('no basa');
    }
    var listSaved = box.keys.toList();

    return Expanded(
      child: ListView.builder(
        itemCount: listSaved.length,
        itemBuilder: (context, index) {
          var dhikr = box.get(listSaved[index]) as Dhikr;

          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                box.deleteAt(index);
              });
            },
            child: Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                color: Color(0xffF9F9F9),
              ),
              width: mapperOrientation(portrait: 90.w, landscape: 150.w),
              height: 6.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 7.w,
                    child: Text(
                      dhikr.counter.toString(),
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff4664FF)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      dhikr.title,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.5.w),
                  Text(
                    '${dhikr.dateTime.toLocal().day.toString()}.${dhikr.dateTime.toLocal().month.toString().padLeft(2, '0')}.${dhikr.dateTime.toLocal().year.toString()}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Colors.black),
                    //  Color(0xff9F9F9F)),
                  ),
                  SizedBox(width: 2.5.w),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
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
                                controller: _counterDhikrController,
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
                            ],
                          ),
                          actions: [
                            FloatingActionButton(
                              onPressed: () async {
                                void editCounter() {
                                  final dhikrFromHive = box
                                      .get(box.keys.toList()[index]) as Dhikr;
                                  dhikrFromHive.counter =
                                      int.parse(_counterDhikrController.text);
                                  dhikrFromHive.title =
                                      _titleDhikrController.text;
                                  dhikrFromHive.dateTime = DateTime.now();
                                }

                                editCounter();

                                box.put(
                                    box.keys.toList()[index].toString(),
                                    Dhikr(
                                        title: _titleDhikrController.text,
                                        counter: int.parse(
                                            _counterDhikrController.text),
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
                        ),
                      );
                    },
                    icon: SvgPicture.asset(
                      'assets/images/setting.svg',
                      height: 1.3.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getObjectFromHive(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        return const Text('non');
      },
    );
  }
}
