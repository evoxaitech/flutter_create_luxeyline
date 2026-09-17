import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class SetupProgressBar extends StatelessWidget {
  final int step; // 1 to 4
  final int totalSteps;
  const SetupProgressBar({super.key, required this.step, this.totalSteps = 4});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (i) {
        final active = i < step;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i == totalSteps - 1 ? 0 : 6),
            height: 4,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
