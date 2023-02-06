import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  T responsive<T>({
    required T df,
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) {
    final wd = MediaQuery.of(this).size.width;
    final hg = MediaQuery.of(this).size.height;
    final ratio = wd / hg;

    // print('     Ratio: ' + ratio.toString());
    // print('     width: ' + wd.toString());
    // print('    height: ' + hg.toString());

    return ratio > 2
        ? (xl ?? lg ?? md ?? sm ?? df)
        : ratio >= 1.5
            ? (lg ?? md ?? sm ?? df)
            : ratio >= 1
                ? (md ?? sm ?? df)
                : ratio >= 0.8
                    ? (sm ?? df)
                    : df;

    // return wd >= 1440
    //     ? (xl ?? lg ?? md ?? sm ?? df)
    //     : wd >= 1100
    //         ? (lg ?? md ?? sm ?? df)
    //         : wd >= 650
    //             ? (md ?? sm ?? df)
    //             : wd > 450
    //                 ? (sm ?? df)
    //                 : df;
  }
}
