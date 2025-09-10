import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double radius;
  final Color activeColor;
  final Color inactiveColor;
  final Color lineColor;
  final double gap;
  final List<String> labels;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.radius,
    required this.activeColor,
    required this.inactiveColor,
    required this.lineColor,
    this.gap = 4,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          final step = (index ~/ 2) + 1;
          final isActive = step == currentStep;
          return _stepCircle(step, isActive);
        } else {
          // Line between circles
          return Expanded(
            child: Container(
              height: 2,
              alignment: Alignment.center,
              child: Container(
                height: 2,
                color: lineColor,
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _stepCircle(int step, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: radius,
                backgroundColor: active ? activeColor : inactiveColor,
                child: Text(
                  step.toString(),
                  style: TextStyle(
                    color: active ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: radius * 2 + 40,
          child: Text(
            labels.length >= step ? labels[step - 1] : "",
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
