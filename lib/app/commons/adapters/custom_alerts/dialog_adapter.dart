import 'package:flutter/widgets.dart';

abstract class IDialogAdapter<T> {
  Future<T> showDialog<T>(Widget child);
  void alertSnackBar(String text);
}
