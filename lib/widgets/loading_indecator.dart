import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingIndecator extends StatelessWidget {
  Color? color;
  LoadingIndecator({this.color});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? AppTheme.primary),
    );
  }
}
