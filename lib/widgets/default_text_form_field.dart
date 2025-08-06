import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? prefixIconImageName;
  String? Function(String?)? validator;
  bool isPassword;

  DefaultTextFormField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIconImageName,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscire = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : SvgPicture.asset(
                "assets/icons/${widget.prefixIconImageName}.svg",
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscire = !isObscire;
                  setState(() {});
                },
                icon: Icon(
                  isObscire
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.grey,
                ),
              )
            : null,
      ),
      validator: widget.validator,
      obscureText: isObscire,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
