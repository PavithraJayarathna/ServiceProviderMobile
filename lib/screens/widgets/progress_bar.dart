import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class StepProgress extends StatelessWidget {
  final int currentStep;
  final List<String> stepTitles;

  const StepProgress({
    super.key,
    required this.currentStep,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Center( // ✅ Center whole progress bar
      child: Row(
        mainAxisSize: MainAxisSize.min, // ✅ shrink to fit content
        children: List.generate(stepTitles.length, (index) {
          final stepNumber = index + 1;
          final isPast = stepNumber < currentStep;
          final isCurrent = stepNumber == currentStep;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPast
                      ? AppColors.success
                      : isCurrent
                          ? AppColors.primary
                          : Colors.transparent,
                  border: !isPast && !isCurrent
                      ? Border.all(
                          color: AppColors.textLight,
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: isPast
                      ? const Icon(
                          Icons.check,
                          color: AppColors.textDark,
                          size: 24,
                        )
                      : Text(
                          "$stepNumber",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isCurrent
                                ? AppColors.cardBg
                                : AppColors.textMedium,
                          ),
                        ),
                ),
              ),

              // Line (except last step)
              if (index < stepTitles.length - 1)
                Container(
                  width: 60, // fixed line width
                  height: 3,
                  margin: const EdgeInsets.only(left: 0, right:20,), // gap before next circle
                  color: isPast ? AppColors.success : AppColors.border,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class StepProgressWithLabels extends StatelessWidget {
  final int currentStep;

  const StepProgressWithLabels({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Personal Details",
      "Professional Details",
      "Account Security"
    ];

    return Column(
      children: [
        StepProgress(currentStep: currentStep, stepTitles: steps),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // ✅ center labels too
          children: List.generate(
            steps.length,
            (index) => Text(
              steps[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
