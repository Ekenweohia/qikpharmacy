import 'package:flutter/material.dart';

import 'package:qik_pharma_mobile/utils/utils.dart';

class EmptyShippingAddressList extends StatelessWidget {
  const EmptyShippingAddressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            height: 150.0,
            width: 150.0,
            margin: const EdgeInsets.only(bottom: 10),
            child: Image.asset(
              "assets/images/shipping.png",
            ),
          ),
          const SizedBox(height: 23),
          Container(
            alignment: Alignment.center,
            child: Text(
              "No available shipping address",
              style: textStyle15w400.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
