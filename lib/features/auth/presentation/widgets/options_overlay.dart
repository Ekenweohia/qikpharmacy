import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

class OptionsOverlay extends StatefulWidget {
  const OptionsOverlay({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.placeholderText,
  }) : super(key: key);

  final List<dynamic> options;
  final ValueChanged<dynamic> selectedOption;
  final String placeholderText;

  @override
  State<OptionsOverlay> createState() => _OptionsOverlayState();
}

class _OptionsOverlayState extends State<OptionsOverlay> {
  final ValueNotifier<bool> isOverlayShown = ValueNotifier(false);
  final selected = ValueNotifier<dynamic>(null);
  final selectedOption = ValueNotifier<dynamic>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOverlayShown.value = !isOverlayShown.value;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selected.value ?? widget.placeholderText,
                  style: textStyle15w400.copyWith(
                    color: AppCustomColors.textBlue.withOpacity(.45),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.black)
              ],
            ),
          ),
        ),
        if (!isOverlayShown.value && selected.value == null)
          const SizedBox(height: 16),
        if (isOverlayShown.value)
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            ),
            child: Column(
              children: List.generate(
                widget.options.length,
                (index) {
                  final item = widget.options[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected.value = item.name;
                        selectedOption.value = item;
                        widget.selectedOption.call(selectedOption.value!);
                        isOverlayShown.value = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selected.value == item.name
                                  ? AppCustomColors.primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: AppCustomColors.primaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Text(
                              '${item.name ?? ''}',
                              style: textStyle12.copyWith(
                                color:
                                    AppCustomColors.textBlue.withOpacity(.45),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
