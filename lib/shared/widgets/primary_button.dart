import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/shared/widgets/circular_loading_widget.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double width;
  final bool hasBorder;
  final Color? borderColor;
  final Color? textColor;
  final bool loading;
  final bool isEnabled;
  final Color buttonColor;

  const PrimaryButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.width = double.infinity,
    this.borderColor,
    this.hasBorder = false,
    this.textColor = Colors.white,
    this.loading = false,
    this.isEnabled = true,
    this.buttonColor = AppCustomColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: hasBorder ? borderColor! : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(56),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (!isEnabled) return Colors.grey;
              if (hasBorder) return Colors.white;
              return buttonColor;
            },
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: loading
            ? CircularLoadingWidget(
                color: textColor ?? Colors.white,
              )
            : Text(
                title,
                style: textStyle13w400.copyWith(
                  color: textColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}
