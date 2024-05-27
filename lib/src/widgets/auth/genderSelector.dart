import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class RadioSelection extends StatelessWidget {
  final String currentGender;
  final Function(String) onChanged;
  final String option1;
  final String option2;

  RadioSelection({
    Key? key,
    required this.currentGender,
    required this.onChanged,
    required this.option1,
    required this.option2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> genderOptions = ['male', 'female'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: genderOptions[0],
          groupValue: currentGender,
          onChanged: (value) => onChanged(value.toString()),
        ),
        Text(option1, style: AppTheme.smallTextGreen),
        Radio(
          value: genderOptions[1],
          groupValue: currentGender,
          onChanged: (value) => onChanged(value.toString()),
        ),
        Text(option2, style: AppTheme.smallTextGreen),
      ],
    );
  }
}
