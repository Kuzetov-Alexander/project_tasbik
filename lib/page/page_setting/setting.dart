import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';
import 'package:tasbix/features/style_text.dart';
import 'package:tasbix/generated/locale_keys.g.dart';

import 'package:tasbix/import.dart';

class SetApp extends StatefulWidget {
  const SetApp({super.key});

  @override
  State<SetApp> createState() => _SetAppState();
}

class _SetAppState extends State<SetApp> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // loadAd();
  }

  // replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  /// Loads a banner ad.
  void loadAd() {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.mediumRectangle,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    final callProvider = context.read<ProviderLocalisation>();
    final user = FirebaseAuth.instance.currentUser;

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
                padding: EdgeInsets.only(top: 1.h, right: 10.w),
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
                          LocaleKeys.settings,
                          style: MyStyle.styleTextBlue,
                        ).tr(),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 2.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(LocaleKeys.lanquage).tr(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    callProvider.editLanquage(context);
                                  });
                                },
                                child: Text(
                                    (context.locale == const Locale('ru'))
                                        ? 'Русский'
                                        : 'English',
                                    style: const TextStyle(
                                        color: Color(0xff4664FF))),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(LocaleKeys.sound).tr(),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('On',
                                      style:
                                          TextStyle(color: Color(0xff4664FF)))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(LocaleKeys.countAsVolume).tr(),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'On',
                                  style: TextStyle(
                                    color: Color(0xff4664FF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Account'),
                              TextButton(
                                onPressed: () {
                                  if (user != null) {
                                    FirebaseAuth.instance.signOut();
                                    FirebaseAuth.instance
                                        .signOut()
                                        .then((value) => context.pop());
                                  } else {
                                    context.go('/signup');
                                  }
                                },
                                child: Text(
                                  user != null ? 'Sign out' : 'Sign In',
                                  style: const TextStyle(
                                    color: Color(0xff4664FF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          user != null
                              ? const SizedBox.shrink()
                              : bannerAd != null
                                  ? Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SafeArea(
                                        child: SizedBox(
                                          width:
                                              bannerAd!.size.width.toDouble(),
                                          height:
                                              bannerAd!.size.height.toDouble(),
                                          child: AdWidget(ad: bannerAd!),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: user == null
                                ? TextButton(
                                    onPressed: () {
                                      context.go('/registration');
                                    },
                                    child: const Text(
                                      'Registration',
                                      style: TextStyle(
                                        color: Color(0xff4664FF),
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      context.go('/registration');
                                    },
                                    child: const Text(
                                      'Delete account',
                                      style: TextStyle(color: Colors.white
                                          //Color(0xff4664FF),
                                          ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
