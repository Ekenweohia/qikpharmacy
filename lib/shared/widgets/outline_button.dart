import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class OutlineButton extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  const OutlineButton({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: OutlinedButton(
        onPressed: () => onPressed!(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: AppCustomColors.primaryColor,
            width: 1,
          ),
        ),
        child: Text(title!, style: textStyle15w500Black),
      ),
    );
  }
}
