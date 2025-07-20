import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  String label;
  IconData icon;
  bool isSelected;
  Color selectedForegroundColor;
  Color unselectedForegroundColor;
  Color selectedBackgroundColor;
  TabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.selectedForegroundColor,
    required this.selectedBackgroundColor,
    required this.unselectedForegroundColor,
  });
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? selectedBackgroundColor : Colors.transparent,
        borderRadius: BorderRadius.circular(46),
        border: isSelected ? null : Border.all(color: AppTheme.white),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected
                ? selectedForegroundColor
                : unselectedForegroundColor,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: textTheme.titleMedium!.copyWith(
              color: isSelected
                  ? selectedForegroundColor
                  : unselectedForegroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
