  import 'package:flutter/material.dart';

  class CustomTextFieldController extends ValueNotifier<String?> {
    final TextEditingController textController;

    bool isPasswordVisible;

    CustomTextFieldController(
      this.textController, {
      String? initialValue,
      this.isPasswordVisible = false,
    }) : super(initialValue) {
      textController.addListener(() {
        value = textController.text;
        notifyListeners();
      });
    }

    bool get hasText => textController.text.isNotEmpty;

    void updateText(String value) {
      textController.text = value;
      this.value = value;
    }

    void togglePasswordVisibility() {
      isPasswordVisible = !isPasswordVisible;
      notifyListeners();
    }

    void clearText() {
      textController.clear();
      value = '';
    }

    @override
    void dispose() {
      textController.dispose();
      super.dispose();
    }
  }
