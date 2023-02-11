


import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

extension TextStyleHelpers on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle primary(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.primary);
  TextStyle onPrimary(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.onPrimary);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle size(double value) => copyWith(fontSize: value);
}

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: const EdgeInsets.all(16), child: this);

  /// Set all side padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Set all side padding according to `value`
  Padding pH(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  Padding pV(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Vertical Padding 16
  Padding get vP16 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: this);
  Padding get vP8 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP12 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP4 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: this);

  ///Horizontal Padding for Title
  Padding get hP30 =>
      Padding(padding: const EdgeInsets.only(left: 30), child: this);

  ///Facebook/Google logo text Padding Helper
  Padding get vP5 =>
      Padding(padding: const EdgeInsets.only(bottom: 5.5), child: this);

  /// Set right side padding according to `value`
  Padding pR(double value) =>
      Padding(padding: EdgeInsets.only(right: value), child: this);

  /// Set left side padding according to `value`
  Padding pL(double value) =>
      Padding(padding: EdgeInsets.only(left: value), child: this);

  /// Set Top side padding according to `value`
  Padding pT(double value) =>
      Padding(padding: EdgeInsets.only(top: value), child: this);

  /// Set bottom side padding according to `value`
  Padding pB(double value) =>
      Padding(padding: EdgeInsets.only(bottom: value), child: this);
}

extension Extended on Widget {
  Expanded get extended => Expanded(
    child: this,
  );
}

extension CornerRadius on Widget {
  ClipRRect get circular => ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(1000)),
    child: this,
  );
  ClipRRect cornerRadius(double value) => ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(value)),
    child: this,
  );
}

extension OnPressed on Widget {
  Widget ripple(
      VoidCallback? onPressed, {
        double? radius,
        BorderRadiusGeometry? borderRadius =
        const BorderRadius.all(Radius.circular(5)),
      }) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: borderRadius ??
                        BorderRadius.all(Radius.circular(radius!)),
                  ),
                ),
              ),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                }
              },
              child: Container(),
            ),
          )
        ],
      );
}

extension ExAlignment on Widget {
  Widget get alignTopCenter => Align(
    alignment: Alignment.topCenter,
    child: this,
  );
  Widget get alignTopLeft => Align(
    alignment: Alignment.topLeft,
    child: this,
  );
  Widget get alignTopRight => Align(
    alignment: Alignment.topRight,
    child: this,
  );
  Widget get alignCenter => Align(
    child: this,
  );

  Widget get alignCenterRight => Align(
    alignment: Alignment.centerRight,
    child: this,
  );
  Widget get alignBottomCenter => Align(
    alignment: Alignment.bottomCenter,
    child: this,
  );
  Widget get alignBottomLeft => Align(
    alignment: Alignment.bottomLeft,
    child: this,
  );
  Widget get alignBottomRight => Align(
    alignment: Alignment.bottomRight,
    child: this,
  );
}

extension StringHelper on String? {
  String takeOnly(int value) {
    if (this != null && this!.length >= value) {
      return this!.substring(0, value);
    } else {
      return this!;
    }
  }

  bool get isNotNullEmpty => this != null && this!.isNotEmpty;

  Option<String> get value {
    if (this != null && this!.isNotEmpty) {
      return some(this!);
    } else {
      return none();
    }
  }

  String orDefault(String defaultValue) =>
      isNotNullEmpty ? this! : defaultValue;

  DateTime? get toDateTime => this != null ? DateTime.tryParse(this!) : null;

  String get toHMTime {
    if (this == null || this!.isEmpty) {
      return '';
    }
    final dt = DateTime.parse(this!).toLocal();
    final dat = DateFormat('hh:mm:ss').format(dt);
    return dat;
  }
}

extension OptionHelper<T> on Option<T> {
  T? get valueOrDefault => fold(() => null, (a) => a);
  T orDefault(T data) => fold(
        () => optionValue.fold(
          () => data,
          (option) => option.fold(() => data, (a) => a),
    ),
        (a) => a,
  );
}

extension ObjectHelper<T> on T? {
  Option<T> get optionValue {
    if (this == null) {
      return none();
    }

    // ignore: null_check_on_nullable_type_parameter
    return some(this!);
  }
}

extension DateTimeExtension on DateTime? {
  String? format([String pattern = 'MMMM dd, yyyy']) {
    if (this == null) {
      return null;
    }

    return DateFormat(pattern).format(this!);
  }


}

extension ThemeHelper on BuildContext {
  ThemeData get theme => Theme.of(this);
  Color get primaryColor => theme.colorScheme.primary;
  Color get onPrimary => theme.colorScheme.onPrimary;
  Color get surfaceColor => theme.colorScheme.surface;
  TextTheme get textTheme => theme.textTheme;
  Color get bodyTextColor => theme.textTheme.bodyText1!.color!;
  Color get disabledColor => theme.disabledColor;
  ColorScheme get colorScheme => theme.colorScheme;
  // ThemeType get themeType =>
  //   theme.brightness == Brightness.light ? ThemeType.LIGHT : ThemeType.DARK;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLandscapeMode =>
      MediaQuery.of(this).orientation == Orientation.landscape;
}

extension NavigationHelper on BuildContext {
  NavigatorState get navigate => Navigator.of(this);
}

extension SizeHelper on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension ListHelper<T> on List<T>? {
  Option<List<T>> get value {
    if (this != null && this!.isNotEmpty) {
      return some(this!);
    } else {
      return none();
    }
  }

  /// Returns the absolute value of the list or null value.
  /// ```dart
  /// final list1 = [1, 2, 3];
  /// final list2 = List<int>.from(list1);
  /// print(result); // [1, 2, 3]
  ///
  /// OR
  ///
  /// final list1 = [1, 2, 3];
  /// final list2 = lis1.getAbsoluteOrNull;
  /// print(result); // [1, 2, 3]
  /// ```
  /// Both above examples will return the same result.
  List<T>? get getAbsoluteOrNull => value.fold(() => null, List<T>.from);

  bool get isNotNullEmpty => this != null && this!.isNotEmpty;

  /// Checks for null value and check if given value is exists in list or not.
  /// ```dart
  /// final list1 = [1, 2, 3];
  /// final result = list1.any((value) => value == 2); // true
  ///
  /// OR
  ///
  /// final result = list1.anyValue(2); // true
  /// ```
  /// Both above examples will return the same result.
  /// First example will only works for non null list however second example
  /// will work for both null and non null list.
  bool anyValue(
      bool Function(T) func,
      ) =>
      value.fold(() => false, (a) => a.any(func));

  T? firstWhereOrNull(bool Function(T element) test) {
    try {
      // ignore: cast_nullable_to_non_nullable
      return (this as List<T>).firstWhere(test);
    } catch (_) {
      return null;
    }
  }

  bool get notNullAndEmpty => this != null && this!.isNotEmpty;

  Widget on({
    required Widget Function() ifNull,
    required Widget Function() ifEmpty,
    required Widget Function() ifValue,
  }) {
    if (this == null) {
      return ifNull();
    } else if (this!.isEmpty) {
      return ifEmpty();
    } else {
      return ifValue();
    }
  }
}

extension EnumExtension on Enum {
  T on<T>() => this as T;
  K? applyWhen<T, K>(Map<T, K> map, {K? defaultValue}) =>
      map[this] ?? defaultValue;
}
