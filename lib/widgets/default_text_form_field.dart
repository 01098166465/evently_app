import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? prefixIconImageName;
  String? Function(String?)? validator;

  DefaultTextFormField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIconImageName,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIconImageName == null
            ? null
            : SvgPicture.asset(
                "assets/icons/$prefixIconImageName.svg",
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
      ),
      validator: validator,
    );
  }
}
