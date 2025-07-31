import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultElevetedButton extends StatelessWidget {
  String label;
  VoidCallback onPressed;
  Color? color;
  Color? textColor;
  String? svgIcon;
  Color? borderColor;

  DefaultElevetedButton({
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.svgIcon,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 56),
        backgroundColor: color ?? AppTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgIcon != null) ...[
            SvgPicture.asset(svgIcon!, height: 25, width: 25),
            SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
