import 'package:flutter/widgets.dart';

abstract class IDialogAdapter<T> {
  Future<T> showDialog<U>(Widget child);
  void alertSnackBar(String text);
}
