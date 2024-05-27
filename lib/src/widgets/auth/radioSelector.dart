import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class RadioSelection extends StatelessWidget {
  final String groupValue;
  final Function(String) onChanged;
  final String option1;
  final String option2;

  RadioSelection({
    Key? key,
    required this.groupValue,
    required this.onChanged,
    required this.option1,
    required this.option2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> options = [option1, option2];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: options[0],
          groupValue: groupValue,
          onChanged: (value) => onChanged(value.toString()),
        ),
        Text(option1, style: AppTheme.smallTextGreen),
        Radio(
          value: options[1],
          groupValue: groupValue,
          onChanged: (value) => onChanged(value.toString()),
        ),
        Text(option2, style: AppTheme.smallTextGreen),
      ],
    );
  }
}
