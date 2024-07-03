import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class StepsProgressComponent extends StatelessWidget {
  final int currentStep;
  final int completedSteps;
  const StepsProgressComponent(
      {Key? key, this.currentStep = 1, this.completedSteps = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProgressArea(),
        const SizedBox(height: 20),
        _buildProgressDescriptionArea(),
      ],
    );
  }

  Color _getStepColor({required int step}) {
    if (step <= currentStep && step <= completedSteps) {
      return AppCustomColors.primaryColor;
    } else if (step == currentStep) {
      return AppCustomColors.darkRed;
    } else {
      return AppCustomColors.nonActiveProgressColor;
    }
  }

  Widget _buildStep({required int stepNumber, required Color stepColor}) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: stepColor,
        shape: BoxShape.circle,
      ),
      child: stepNumber < 3
          ? Center(
              child: Text(
                stepNumber.toString(),
                style: textStyle17w400.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          : const Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
    );
  }

  Widget _buildLine({required int lineNumber}) {
    return Expanded(
      child: Container(
        height: 8,
        color: completedSteps >= lineNumber
            ? AppCustomColors.primaryColor
            : const Color(0XFFC4C4C4),
      ),
    );
  }

  Widget _buildProgressArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStep(
            stepNumber: 1,
            stepColor: _getStepColor(step: 1),
          ),
          _buildLine(lineNumber: 1),
          _buildStep(
            stepNumber: 2,
            stepColor: _getStepColor(step: 2),
          ),
          _buildLine(lineNumber: 2),
          _buildStep(
            stepNumber: 3,
            stepColor: _getStepColor(step: 3),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDescriptionArea() {
    return Padding(
      padding: const EdgeInsets.only(right: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Verify Identity",
            style: _buildStepTextStyle(step: 1),
          ),
          Expanded(child: Container()),
          Text(
            "Change Email",
            style: _buildStepTextStyle(step: 2),
          ),
          Expanded(child: Container()),
          Text(
            "Finished",
            style: _buildStepTextStyle(step: 3),
          ),
        ],
      ),
    );
  }

  TextStyle _buildStepTextStyle({required int step}) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: _getStepColor(step: step),
    );
  }
}
