import 'package:flutter/material.dart';

class MyAppHelper {
  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery
        .of(context)
        .viewInsets
        .bottom > 0;
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.unfocus();
    }
  }

}