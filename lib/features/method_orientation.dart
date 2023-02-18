import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

T mapperOrientation<T>({required T portrait, required T landscape}) {
  if (SizerUtil.orientation == Orientation.portrait) {
    return portrait;
  }
  return landscape;
}
