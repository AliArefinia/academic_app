import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: Center(
        child: Platform.isIOS
            ?  CupertinoActivityIndicator(color: context.colorScheme.onPrimary,)
            : const CircularProgressIndicator(),
      ),
    );
  }
}
