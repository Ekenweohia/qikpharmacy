import 'package:flutter/material.dart';
import 'package:qik_pharma_mobile/core/models/response/role.dart';
import 'package:qik_pharma_mobile/shared/extensions/string_extension.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';

class AccountTypeOverlay extends StatefulWidget {
  const AccountTypeOverlay({
    Key? key,
    required this.roles,
    required this.selectedRole,
  }) : super(key: key);

  final List<Role> roles;
  final ValueChanged<Role> selectedRole;

  @override
  State<AccountTypeOverlay> createState() => _AccountTypeOverlayState();
}

class _AccountTypeOverlayState extends State<AccountTypeOverlay> {
  final ValueNotifier<bool> isOverlayShown = ValueNotifier(false);
  final selected = ValueNotifier<String?>(null);
  final selectedRole = ValueNotifier<Role?>(null);

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
            padding: const EdgeInsets.only(bottom: 6),
            alignment: Alignment.bottomLeft,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppCustomColors.primaryColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selected.value?.capitalize ?? 'Select',
                    style: textStyle15w400),
                Icon(
                  isOverlayShown.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                )
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
                widget.roles.length,
                (index) {
                  final item = widget.roles[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selected.value = item.name;
                        selectedRole.value = item;
                        widget.selectedRole.call(selectedRole.value!);
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
                          Text(
                            item.name?.capitalize ?? '',
                            style: textStyle15w300,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        if (!isOverlayShown.value) const SizedBox(height: 54),
      ],
    );
  }
}
