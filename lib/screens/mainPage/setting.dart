// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SetApp extends StatefulWidget {
  const SetApp({super.key});

  @override
  State<SetApp> createState() => _SetAppState();
}

class _SetAppState extends State<SetApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
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
            backgroundColor: const Color(0xffE5E5E5),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Color(0xff4664FF),
                              )),
                          const Text('Settings'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Lanquage'),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                if (context.locale == const Locale('ru')) {
                                  context.setLocale(const Locale('en'));
                                } else {
                                  context.setLocale(const Locale('ru'));
                                }
                              });
                            },
                            child: Text(
                                (context.locale == const Locale('ru'))
                                    ? 'Russian'
                                    : 'English',
                                style:
                                    const TextStyle(color: Color(0xff4664FF))),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sound'),
                          TextButton(
                              onPressed: () {},
                              child: const Text('On',
                                  style: TextStyle(color: Color(0xff4664FF)))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Vibration'),
                          TextButton(
                              onPressed: () {},
                              child: const Text('On',
                                  style: TextStyle(color: Color(0xff4664FF)))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Count as volume keys'),
                          TextButton(
                              onPressed: () {},
                              child: const Text('On',
                                  style: TextStyle(color: Color(0xff4664FF)))),
                        ],
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
