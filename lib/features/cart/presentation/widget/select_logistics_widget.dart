import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/response/logistics.dart';
import 'package:qik_pharma_mobile/utils/utils.dart';

final LayerLink layerLink = LayerLink();

class SelectLogisticsOverlay extends StatefulWidget {
  const SelectLogisticsOverlay({
    Key? key,
    required this.logistics,
    required this.selectedLogistics,
  }) : super(key: key);

  final List<Logistics> logistics;
  final ValueChanged<Logistics?> selectedLogistics;

  @override
  State<SelectLogisticsOverlay> createState() => _SelectLogisticsOverlayState();
}

class _SelectLogisticsOverlayState extends State<SelectLogisticsOverlay> {
  final ValueNotifier<bool> isOverlayShown = ValueNotifier(false);
  final selectedCompany = ValueNotifier<String?>(null);
  final selectedLogistics = ValueNotifier<Logistics?>(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedCompany.value == null)
          GestureDetector(
            onTap: () {
              setState(() {
                isOverlayShown.value = !isOverlayShown.value;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose Logistics Company',
                    style: textStyle16Bold.copyWith(
                      color: AppCustomColors.textBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey)
                ],
              ),
            ),
          ),
        if (!isOverlayShown.value && selectedCompany.value == null)
          const SizedBox(height: 16),
        if (isOverlayShown.value)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                widget.logistics.length,
                (index) {
                  final item = widget.logistics[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCompany.value = item.name;
                        selectedLogistics.value = item;
                        widget.selectedLogistics.call(selectedLogistics.value!);
                        isOverlayShown.value = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name ?? '',
                            style: textStyle14w400.copyWith(
                              color: AppCustomColors.textBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedCompany.value == item.name
                                  ? AppCustomColors.primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
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
          )
        else if (selectedCompany.value != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/icons/ic_coupon.png",
                  height: 16,
                  width: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedCompany.value!,
                    style: textStyle14w500LightPrimaryColor,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    setState(() {
                      isOverlayShown.value = true;
                      selectedCompany.value = null;
                      selectedLogistics.value = null;

                      widget.selectedLogistics.call(selectedLogistics.value);
                    });
                  },
                  child: Image.asset(
                    "assets/images/icons/ic_rounded_close.png",
                    height: 18,
                    width: 18,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
